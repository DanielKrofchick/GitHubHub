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
            var id: String { avatar.id }
            let link: Any?
            let avatar: AvatarView.Model
            let color: Color
        }
        let load: Load
        let title: String?
        let items: [Item]?
    }
}

struct ReviewersView: View {
    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
            } label: {
                AvatarView(model: item.avatar)
                    .border(item.color, width: 2)
            }
        }
        .navigationTitle(model.title ?? "")
        .onAppear {
            loadData()
        }
    }
}

extension ReviewersView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub().reviewers(
                    owner: model.load.organization,
                    name: model.load.repository,
                    number: model.load.PR
                )

                if let errors = response.errors { throw errors }

                model = Model(
                    load: model.load,
                    title: response.data?.repository?.pullRequest?.fragments.pullRequestFragment.title,
                    items: response.data?.repository?.pullRequest?.fragments
                        .pullRequestFragment.latestReviews?.nodes?
                        .compactMap { $0?.fragments.pullRequestReviewFragment }
                        .compactMap { ReviewersView.Model.Item($0) }
                )
            } catch {
                print(error)
            }
        }
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

private extension ReviewersView.Model.Item {
    init?(_ fragment: PullRequestReviewFragment) {
        guard let actorFragment = fragment.author?.fragments.actorFragment else { return nil }

        self.init(
            link: nil,
            avatar: .init(actorFragment),
            color: fragment.state.color
        )
    }
}
