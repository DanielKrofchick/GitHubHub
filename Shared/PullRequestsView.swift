//
//  PullRequestsView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

struct PullRequestsView: View {
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
        let items: [Item]?
    }

    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                ReviewersView(model: item.link)
            } label: {
                PullRequestCellView(model: item.model)
            }
        }
        .navigationTitle("Pull Requests")
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let response = try await GitHub().pullRequests(owner: model.load.organization, name: model.load.repository)

                if let errors = response.errors {
                    throw errors
                }
                model = Model(
                    load: model.load,
                    items:  response.data?.repository?.pullRequests.nodes?
                        .compactMap { $0?.fragments.pullRequestFragment }
                        .map { PullRequestsView.Model.Item($0) }
                )
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
                items:  nil
            )
        )
    }
}

private extension PullRequestsView.Model.Item {
    init(_ fragment: PullRequestFragment) {
        self.init(
            id: fragment.id,
            link: .init(
                load: .init(
                    organization: fragment.repository.owner.login,
                    repository: fragment.repository.name,
                    PR: fragment.number
                ),
                items: nil
            ),
            model: .init(
                title: fragment.title,
                author: (fragment.author?.fragments.actorFragment)
                    .map {
                        AvatarView.Model.init(
                            $0,
                            color: fragment.isDraft ? .gray : nil
                        )
                    },
                reviewers: fragment.latestOpinionatedReviews?.nodes?
                    .compactMap { $0?.fragments.pullRequestReviewFragment }
                    .compactMap { AvatarView.Model.init($0) }
            )
        )
    }
}