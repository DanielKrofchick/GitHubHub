//
//  ReviewersView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

struct ReviewersView: View {
    struct Model {
        struct Load {
            let owner: String
            let name: String
            let number: Int
        }
        struct Item: Identifiable {
            var id: String { avatar.id }
            let load: Any?
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
                let response = try await GitHub().reviewers(
                    owner: model.load.owner,
                    name: model.load.name,
                    number: model.load.number
                )

                if let errors = response.errors {
                    throw errors
                }
                model = Model(
                    load: model.load,
                    items:  response.data?.repository?.pullRequest?.reviewRequests?.nodes?
                        .compactMap { $0?.requestedReviewer?.asUser?.fragments.reviewerFragment }
                        .map { ReviewersView.Model.Item($0) }
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
                    owner: defaultOrganization,
                    name: defaultRepository,
                    number: defaultPullRequest
                ),
                items:  nil
            )
        )
    }
}

private extension ReviewersView.Model.Item {
    init(_ fragment: ReviewerFragment) {
        self.init(
            load: nil,
            avatar: .init(fragment)
        )
    }
}
