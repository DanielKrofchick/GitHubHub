//
//  PullRequestCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-10.
//

import SwiftUI
import OrderedCollections

extension PullRequestCellView {
    struct Model {
        let title: String?
        let author: AvatarAgeView.Model?
        let reviewers: [AvatarAgeView.Model]?
    }
}

struct PullRequestCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            if let author = model.author {
                AvatarAgeView(model: author, size: 30)
            }
            VStack {
                if let title = model.title {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .top) {
                    ForEach(model.reviewers ?? []) { reviewer in
                        AvatarAgeView(model: reviewer, size: 20)
                            .border(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

extension PullRequestCellView.Model {
    init(_ fragment: PullRequestFragment) {
        let reviewRequests: [AvatarAgeView.Model]? = fragment.reviewRequests?.nodes?
            .compactMap { $0?.fragments.reviewRequestFragment.requestedReviewer?.fragments.actorFragment }
            .compactMap {
                AvatarAgeView.Model(
                    avatar: AvatarView.Model($0),
                    age: nil
                )
            }
        let latestReviews: [AvatarAgeView.Model]? = fragment.latestReviews?.nodes?
            .compactMap { $0?.fragments.pullRequestReviewFragment }
            .compactMap {
                guard let avatar = AvatarView.Model(fragment: $0) else { return nil }

                return AvatarAgeView.Model(
                    avatar: avatar,
                    age: $0.submittedAt?.date?.relative()
                )
            }

        var reviewers = OrderedSet<AvatarAgeView.Model>()
        reviewRequests?.forEach { reviewers.updateOrAppend($0) }
        latestReviews?.forEach { reviewers.updateOrAppend($0) }

        self.init(
            title: fragment.title,
            author: (fragment.author?.fragments.actorFragment).map {
                AvatarAgeView.Model(
                    avatar: AvatarView.Model.init(
                        $0,
                        color: fragment.isDraft ? .gray : nil
                    ),
                    age: fragment.createdAt.date?.relative()
                )
            },
            reviewers: reviewers.filter { $0.avatar.color != nil } + reviewers.filter { $0.avatar.color == nil }
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

struct PullRequestCellView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestCellView(
            model: .init(
                title: "[AB-123] This is a PR for updating the user colors to the new ones that everyone wants dasd asds dsa",
                author: .init(
                    avatar: .init(
                        id: "1",
                        avatarURL: defaultAvatarURL,
                        color: .gray
                    ),
                    age: "10d"
                ),
                reviewers: [
                    .init(
                        avatar: .init(
                            id: "1",
                            avatarURL: defaultAvatarURL,
                            color: .red
                        ),
                        age: "1D"
                    ),
                    .init(
                        avatar: .init(
                            id: "2",
                            avatarURL: defaultAvatarURL,
                            color: .orange
                        ),
                        age: "2W"
                    ),
                    .init(
                        avatar: .init(
                            id: "3",
                            avatarURL: defaultAvatarURL,
                            color: .green
                        ),
                        age: "3Y"
                    ),
                    .init(
                        avatar: .init(
                            id: "4",
                            avatarURL: defaultAvatarURL
                        ),
                        age: nil
                    )
                ]
            )
        )
    }
}
