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
        let items: [Item]?
    }

    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
            } label: {
                AvatarView(model: item.avatar)
                    .border(item.color, width: 2)
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
                    owner: model.load.organization,
                    name: model.load.repository,
                    number: model.load.PR
                )

                if let errors = response.errors { throw errors }

                model = Model(
                    load: model.load,
                    items:  response.data?.repository?.pullRequest?.latestOpinionatedReviews?.nodes?
                        .compactMap {
                            if
                                let reviewer = $0?.author?.fragments.reviewerFragment,
                                let state = $0?.state
                            {
                                return (reviewer: reviewer, state: state)
                            }

                            return nil
                        }
                        .map { ReviewersView.Model.Item($0.reviewer, state: $0.state) }
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
                items:  nil
            )
        )
    }
}

private extension ReviewersView.Model.Item {
    init(_ fragment: ReviewerFragment, state: PullRequestReviewState) {
        self.init(
            link: nil,
            avatar: .init(fragment),
            color: state.color
        )
    }
}

extension PullRequestReviewState {
    var color: Color {
        switch self {
        case .pending:
            return .gray
        case .commented:
            return .orange
        case .approved:
            return .green
        case .changesRequested:
            return .red
        case .dismissed:
            return .blue
        case .__unknown:
            return .black
        }
    }
}
