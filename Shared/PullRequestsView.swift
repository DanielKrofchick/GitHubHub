//
//  PullRequestsView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

extension PullRequestsView {
    struct Model {
        struct Load {
            let organization: String
            let repository: String
            var isCompact: Bool
        }
        struct Item: Identifiable {
            let id: String
            let link: ReviewersView.Model
            let model: PullRequestCellView.Model
        }
        var load: Load
        let title: String?
        let items: [Item]?
        let rateLimit: String?
    }
}

extension PullRequestsView.Model {
    func setIsCompact(_ isCompact: Bool) -> Self {
        var result = self
        result.load.isCompact = isCompact
        return result
    }
}

struct PullRequestsView: View {
    @State var model: Model
    @EnvironmentObject var rateLimit: RateLimitCoordinator
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if isLoading {
                list.hidden()
                ProgressView()
            } else {
                list
            }
        }
        .navigationTitle(model.title ?? "")
        .onAppear {
            loadData()
        }
    }

    private var list: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                ReviewersView(model: item.link)
            } label: {
                if model.load.isCompact {
                    PullRequestCompactCellView(model: item.model)
                } else {
                    PullRequestCellView(model: item.model)
                }
            }
        }
        .refreshable {
            loadData()
        }
    }
}

extension PullRequestsView {
    private func loadData() {
        Task {
            do {
                isLoading = true
                let response = try await GitHub.shared.pullRequests(
                    owner: model.load.organization,
                    name: model.load.repository
                )

                if let errors = response.errors {
                    throw errors
                }

                model = .init(response.data, load: model.load)

                if let rateLimit = model.rateLimit {
                    self.rateLimit.text = rateLimit
                }
                isLoading = false
            } catch {
                print(error)
            }
        }
    }
}

struct PullRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsView(
            model: .init(
                load: .init(
                    organization: defaultOrganization,
                    repository: defaultRepository,
                    isCompact: false
                ),
                title: nil,
                items: nil,
                rateLimit: nil
            )
        )
    }
}

extension PullRequestsView.Model {
    init(_ data: PullRequestsQuery.Data?, load: Load) {
        self.init(
            load: load,
            title: data?.repository?.name,
            items: data?.repository?.pullRequests.nodes?
                .compactMap { $0?.fragments.pullRequestFragment }
                .map { PullRequestsView.Model.Item($0) }
                .reversed(),
            rateLimit: data?.rateLimit?.fragments.rateLimitFragment.description ?? ""
        )
    }
}

extension PullRequestsView.Model {
    init(_ fragment: RepositoryFragment, isCompact: Bool) {
        self.init(
            load: .init(
                organization: fragment.owner.login,
                repository: fragment.name,
                isCompact: isCompact
            ),
            title: fragment.name,
            items: nil,
            rateLimit: nil
        )
    }
}

private extension PullRequestsView.Model.Item {
    init(_ fragment: PullRequestFragment) {
        self.init(
            id: fragment.id,
            link: ReviewersView.Model(fragment),
            model: PullRequestCellView.Model(fragment)
        )
    }
}
