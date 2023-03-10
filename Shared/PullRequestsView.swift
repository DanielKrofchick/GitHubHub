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
            var id: String { avatar.id }
            let link: ReviewersView.Model
            let avatar: AvatarView.Model
            let reviewers: [AvatarView.Model]
            let color: Color?
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
                VStack {
                    AvatarView(model: item.avatar)
                        .border(item.color ?? .clear, width: 2)
                    HStack {
                        ForEach(item.reviewers) {
                            AvatarView(model: $0)
                        }
                    }
                }
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
                        .compactMap { $0?.fragments.pullRequestReviewsFragment }
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
    init(_ fragment: PullRequestReviewsFragment) {
        let baseFragment = fragment.fragments.pullRequestFragment
        self.init(
            link: .init(
                load: .init(
                    organization: baseFragment.repository.owner.login,
                    repository: baseFragment.repository.name,
                    PR: baseFragment.number
                ),
                items: nil
            ),
            avatar: .init(baseFragment),
            reviewers: fragment.latestOpinionatedReviews?.nodes?
                .compactMap {
                    if
                        let reviewer = $0?.author?.fragments.reviewerFragment,
                        let state = $0?.state
                    {
                        return (reviewer: reviewer, state: state)
                    }

                    return nil
                }
                .map { .init($0.reviewer) } ?? [],
            color: baseFragment.isDraft ? .gray : nil
        )
    }
}
