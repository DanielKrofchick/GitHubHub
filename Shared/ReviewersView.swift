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
            let link: UserPullRequestsView.Model
            let avatar: AvatarAgeView.Model
            let name: String?
            let backgroundColor: Color?
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
                UserPullRequestsView(model: item.link)
            } label: {
                HStack {
                    AvatarAgeView(model: item.avatar, size: 40)
                    Spacer(minLength: 15)
                    if let name = item.name {
                        Text(name)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .background(item.backgroundColor)
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

                let pullRequestFragment = response.data?.repository?.pullRequest?.fragments.pullRequestFragment
                let author = pullRequestFragment.map { AvatarAgeView.Model.author($0) } ?? nil
                let reviewers = pullRequestFragment.map { AvatarAgeView.Model.reviewers($0) }

                var items = [ReviewersView.Model.Item]()

                if let author {
                    items.append(
                        .init(
                            link: UserPullRequestsView.Model(
                                author,
                                organization: model.load.organization,
                                repository: model.load.repository
                            ),
                            avatar: author.set(name: nil),
                            name: author.avatar.name,
                            backgroundColor: .yellow
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
                            avatar: $0.set(name: nil),
                            name: $0.avatar.name,
                            backgroundColor: nil
                        )
                    )
                }

                model = Model(
                    load: model.load,
                    title: pullRequestFragment?.title,
                    items: items
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
