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
        let author: AvatarView.Model?
        let age: String?
        let reviewers: [Reviewer]?
        struct Reviewer: Identifiable, Hashable {
            var id: String { avatar.id }
            let avatar: AvatarView.Model
            let age: String?
        }
    }
}

struct PullRequestCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            VStack {
                if let author = model.author {
                    AvatarView(model: author, size: 30)
                }
                if let age = model.age {
                    Text(age)
                }
            }
            VStack {
                if let title = model.title {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .top) {
                    ForEach(model.reviewers ?? []) { reviewer in
                        VStack {
                            AvatarView(model: reviewer.avatar, size: 20)
                                .frame(alignment: .top)
                            if let age = reviewer.age {
                                Text(age)
                            }
                        }
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
        let reviewRequests: [PullRequestCellView.Model.Reviewer]? = fragment.reviewRequests?.nodes?
            .compactMap { $0?.fragments.reviewRequestFragment.requestedReviewer?.fragments.actorFragment }
            .compactMap {
                PullRequestCellView.Model.Reviewer(
                    avatar: AvatarView.Model.init($0),
                    age: nil
                )
            }
        let latestReviews: [PullRequestCellView.Model.Reviewer]? = fragment.latestReviews?.nodes?
            .compactMap { $0?.fragments.pullRequestReviewFragment }
            .compactMap {
                guard let avatar = AvatarView.Model(fragment: $0) else { return nil }

                return PullRequestCellView.Model.Reviewer(
                    avatar: avatar,
                    age: $0.submittedAt?.date?.relative()
                )
            }

        var reviewers = OrderedSet<PullRequestCellView.Model.Reviewer>()
        reviewRequests?.forEach { reviewers.updateOrAppend($0) }
        latestReviews?.forEach { reviewers.updateOrAppend($0) }

        self.init(
            title: fragment.title,
            author: (fragment.author?.fragments.actorFragment).map {
                AvatarView.Model.init(
                    $0,
                    color: fragment.isDraft ? .gray : nil
                )
            },
            age: fragment.createdAt.date?.relative(),
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
                    id: "1",
                    avatarURL: defaultAvatarURL,
                    color: .gray
                ),
                age: "10d",
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
