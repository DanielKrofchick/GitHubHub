//
//  ReviewersView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

extension ReviewersView {
    struct Model {
        struct Load {
            let organization: String
            let repository: String
            let PR: Int
        }
        struct Item: Identifiable {
            var id: String { model.avatar.id }
            let link: UserPullRequestsView.Model
            let model: ReviewerCellView.Model
        }
        let load: Load
        let title: String?
        let items: [Item]?
    }
}

struct ReviewersView: View {
    @State var model: Model
    @State private var isLoading = false

    var body: some View {
        LoadingView(loader: self) {
            List(model.items ?? []) { item in
                NavigationLink {
                    UserPullRequestsView(model: item.link)
                } label: {
                    ReviewerCellView(model: item.model)
                }
            }
        }
    }
}

extension ReviewersView: Loadable {
    func load() async throws {
        let response = try await GitHub.shared.reviewers(
            owner: model.load.organization,
            name: model.load.repository,
            number: model.load.PR
        )

        if let errors = response.errors { throw errors }

        let pullRequestFragment = response.data?.repository?.pullRequest?.fragments.pullRequestFragment
        let author = pullRequestFragment.map { AvatarView.Model.author($0) } ?? nil
        let reviewers = pullRequestFragment.map { AvatarView.Model.reviewers($0) }

        var items = [ReviewersView.Model.Item]()

        if let author {
            items.append(
                .init(
                    link: UserPullRequestsView.Model(
                        author,
                        organization: model.load.organization,
                        repository: model.load.repository
                    ),
                    model: .init(
                        avatar: author,
                        name: author.id,
                        backgroundColor: nil,
                        count: nil,
                        organization: pullRequestFragment?.repository.owner.login,
                        rateLimit: response.data?.rateLimit?.fragments.rateLimitFragment.description
                    )
                )
            )
        }

        reviewers?.forEach {
            items.append(
                .init(
                    link: UserPullRequestsView.Model(
                        $0,
                        organization: model.load.organization,
                        repository: model.load.repository
                    ),
                    model: .init(
                        avatar: $0,
                        name: $0.id,
                        backgroundColor: .gray,
                        count: nil,
                        organization: pullRequestFragment?.repository.owner.login,
                        rateLimit: response.data?.rateLimit?.fragments.rateLimitFragment.description
                    )
                )
            )
        }

        model = Model(
            load: model.load,
            title: pullRequestFragment?.title,
            items: items
        )
    }
}

struct ReviewersView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewersView(
            model: .init(
                load: .init(
                    organization: defaultOrganization,
                    repository: defaultRepository,
                    PR: defaultPullRequest
                ),
                title: nil,
                items: nil
            )
        )
    }
}

extension ReviewersView.Model {
    init(_ fragment: PullRequestFragment) {
        self.init(
            load: .init(
                organization: fragment.repository.owner.login,
                repository: fragment.repository.name,
                PR: fragment.number
            ),
            title: fragment.title,
            items: nil
        )
    }
}
