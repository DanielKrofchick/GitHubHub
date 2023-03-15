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
        }
        struct Item: Identifiable {
            var id: String
            let link: PullRequestsView.Model
            let model: RepositoryCellView.Model
        }
        let load: Load
        let title: String?
        let items: [Item]?
        let rateLimit: String?
    }
}

struct RepositoriesView: View {
    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                PullRequestsView(model: item.link)
            } label: {
                RepositoryCellView(model: item.model)
            }
        }
        .navigationTitle(model.title ?? "")
        .toolbar {
            if let rateLimit = model.rateLimit {
                Text(rateLimit)
            }
        }
        .onAppear {
            loadData()
        }
    }
}

extension RepositoriesView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub().repositories(model.load.organization)

                if let errors = response.errors {
                    throw errors
                }

                model = .init(response.data, load: model.load)
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
                load: .init(organization: defaultLogin),
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

extension RepositoriesView.Model {
    init(_ fragment: OrganizationFragment) {
        self.init(
            load: .init(organization: fragment.login),
            title: fragment.login,
            items: nil,
            rateLimit: nil
        )
    }
}

private extension RepositoriesView.Model.Item {
    init(_ fragment: RepositoryFragment) {
        self.init(
            id: fragment.id,
            link: PullRequestsView.Model(fragment),
            model: RepositoryCellView.Model(fragment)
        )
    }
}
