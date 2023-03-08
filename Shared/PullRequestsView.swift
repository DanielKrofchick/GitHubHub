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
            let owner: String
            let name: String
        }
        struct Item: Identifiable {
            var id: String { avatar.id }
            let load: ReviewersView.Model
            let avatar: AvatarView.Model
        }
        let load: Load
        let items: [Item]?
    }

    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
            } label: {
                AvatarView(model: item.avatar)
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
                let response = try await GitHub().pullRequests(owner: model.load.owner, name: model.load.name)

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
                    owner: defaultOrganization,
                    name: defaultRepository
                ),
                items:  nil
            )
        )
    }
}

private extension PullRequestsView.Model.Item {
    init(_ fragment: PullRequestFragment) {
        self.init(
            load: .init(
                avatars: []
            ),
            avatar: .init(fragment)
        )
    }
}
