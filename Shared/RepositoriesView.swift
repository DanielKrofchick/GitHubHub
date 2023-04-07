//
//  RepositoriesView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

extension RepositoriesView {
    struct Model {
        struct Load {
            let organization: String
            var isCompact: Bool
        }
        struct Item: Identifiable {
            var id: String
            let link: PullRequestsView.Model
            let model: RepositoryCellView.Model
        }
        var load: Load
        let title: String?
        let items: [Item]?
        let rateLimit: String?
    }
}

struct RepositoriesView: View {
    @State var model: Model
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        VStack {
            if model.load.isCompact {
                compact
            } else {
                normal
            }
        }
        .toolbar {
            Toggle(isOn: $model.load.isCompact) {
                Image(systemName: "list.bullet.circle")
            }
        }
    }
}

extension RepositoriesView {
    private var normal: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                PullRequestsView(model: item.link)
            } label: {
                RepositoryCellView(model: item.model)
            }
        }
        .navigationTitle(model.title ?? "")
        .onAppear {
            loadData()
        }
    }

    private var compact: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(model.items?.filter { Int($0.model.count ?? "") ?? 0 > 0 } ?? []) { item in
                    VStack {
                        RepositoryCellView(model: item.model)
                            .padding()
                        PullRequestsView(model: item.link.setIsCompact(model.load.isCompact))
                            .listStyle(.plain)
                    }
                    .background(.white)
                }
                .frame(idealWidth: 300)
                .padding(0)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        }
        .navigationTitle(model.title ?? "")
        .onAppear {
            loadData()
        }
    }
}

extension RepositoriesView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub.shared.repositories(model.load.organization)

                if let errors = response.errors {
                    throw errors
                }

                model = .init(response.data, load: model.load)

                if let rateLimit = model.rateLimit {
                    self.rateLimit.text = rateLimit
                }
            } catch {
                print(error)
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView(
            model: .init(
                load: .init(
                    organization: defaultLogin,
                    isCompact: false
                ),
                title: nil,
                items: nil,
                rateLimit: nil
            )
        )
    }
}

private extension RepositoriesView.Model {
    init(_ data: RepositoriesQuery.Data?, load: Load) {
        self.init(
            load: load,
            title: data?.organization?.login,
            items: data?.organization?.repositories.nodes?
                .compactMap { $0?.fragments.repositoryFragment }
                .sorted {
                    (
                        $0.pullRequests.totalCount,
                        $0.pushedAt?.date ?? Date(),
                        $1.name
                    )
                    >
                    (
                        $1.pullRequests.totalCount,
                        $1.pushedAt?.date ?? Date(),
                        $0.name
                    )
                }
                .map { RepositoriesView.Model.Item($0) },
            rateLimit: data?.rateLimit?.fragments.rateLimitFragment.description
        )
    }
}

private extension RepositoriesView.Model.Item {
    init(_ fragment: RepositoryFragment) {
        self.init(
            id: fragment.id,
            link: PullRequestsView.Model(fragment, isCompact: false),
            model: RepositoryCellView.Model(fragment)
        )
    }
}
