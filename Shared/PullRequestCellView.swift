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
                AvatarAgeView(model: author, size: 50)
            }
            VStack {
                if let title = model.title {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(model.reviewers ?? []) { reviewer in
                            AvatarAgeView(model: reviewer, size: 40)
                                .border(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct PullRequestCompactCellView: View {
    @State var model: PullRequestCellView.Model

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                if let author = model.author {
                    AvatarAgeView(model: author, size: 25)
                }
                ForEach(model.reviewers ?? []) { reviewer in
                    AvatarAgeView(model: reviewer, size: 25)
                        .border(.gray)
                }
            }
            .padding(0)
        }
    }
}


extension AvatarAgeView.Model {
    static func reviewers(_ fragment: PullRequestFragment) -> [AvatarAgeView.Model] {
        let reviewRequests: [AvatarAgeView.Model]? = fragment.reviewRequests?.nodes?
            .compactMap { $0?.fragments.reviewRequestFragment.requestedReviewer?.fragments.actorFragment }
            .compactMap {
                .init(
                    avatar: .init(
                        $0,
                        color: nil,
                        hasName: true
                    ),
                    age: nil
                )
            }

        let latestReviews: [AvatarAgeView.Model]? = fragment.latestReviews?.nodes?
            .compactMap { $0?.fragments.pullRequestReviewFragment }
            .compactMap {
                guard let author = $0.author else { return nil }

                return .init(
                    avatar: .init(
                        author.fragments.actorFragment,
                        color: $0.state.color,
                        hasName: true
                    ),
                    age: $0.submittedAt?.date?.relativeAttributed
                )
            }

        var reviewers = OrderedSet<AvatarAgeView.Model>()
        reviewRequests?.forEach { reviewers.updateOrAppend($0) }
        latestReviews?.forEach { reviewers.updateOrAppend($0) }

        return reviewers.filter { $0.avatar.color != nil } + reviewers.filter { $0.avatar.color == nil }
    }

    static func author(_ fragment: PullRequestFragment) -> AvatarAgeView.Model? {
        guard let actor = fragment.author?.fragments.actorFragment else { return nil }

        return AvatarAgeView.Model(
            avatar: .init(
                actor,
                color: fragment.isDraft ? .gray : nil,
                hasName: true
            ),
            age: fragment.createdAt.date?.relativeAttributed
        )
    }

    func set(name: String?) -> Self {
        Self.init(
            avatar: .init(
                id: avatar.id,
                name: name,
                avatarURL: avatar.avatarURL,
                color: avatar.color
            ),
            age: age
        )
    }
}

extension PullRequestCellView.Model {
    init(_ fragment: PullRequestFragment) {
        self.init(
            title: fragment.title,
            author: AvatarAgeView.Model.author(fragment).map { $0.set(name: nil) },
            reviewers: AvatarAgeView.Model.reviewers(fragment).map { $0.set(name: nil) }
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
