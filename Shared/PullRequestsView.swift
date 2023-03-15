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
        }
        struct Item: Identifiable {
            let id: String
            let link: ReviewersView.Model
            let model: PullRequestCellView.Model
        }
        let load: Load
        let title: String?
        let items: [Item]?
        let rateLimit: String?
    }
}

struct PullRequestsView: View {
    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                ReviewersView(model: item.link)
            } label: {
                PullRequestCellView(model: item.model)
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

extension PullRequestsView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub().pullRequests(
                    owner: model.load.organization,
                    name: model.load.repository
                )

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

struct PullRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsView(
            model: .init(
                load: .init(
                    organization: defaultOrganization,
                    repository: defaultRepository
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
    init(_ fragment: RepositoryFragment) {
        self.init(
            load: .init(
                organization: fragment.owner.login,
                repository: fragment.name
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

extension RateLimitFragment {
    var description: String {
        "-\(cost) | \(remaining)"
    }
}
