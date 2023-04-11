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
        let number: String?
        let title: String?
        let author: AvatarView.Model?
        let reviewers: [AvatarView.Model]?
    }
}

struct PullRequestCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            if let author = model.author {
                AvatarView(model: author, size: 50)
            }
            VStack {
                if let title = model.title {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(model.reviewers ?? []) { reviewer in
                            AvatarView(model: reviewer, size: 40)
                                .border(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .allowsHitTesting(false)
            }
        }
    }
}

struct PullRequestCompactCellView: View {
    @State var model: PullRequestCellView.Model

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center) {
                Text(model.number ?? "")
                    .rotationEffect(.degrees(-90))
                    .fixedSize()
                    .frame(width: 15)
                    .padding(.leading, 5)
                HStack(alignment: .top) {
                    if let author = model.author {
                        AvatarView(model: author, size: 25)
                    }
                    ForEach(model.reviewers ?? []) { reviewer in
                        AvatarView(model: reviewer, size: 25)
                            .border(.gray)
                    }
                }
            }
            .padding(0)
        }
        .allowsHitTesting(false)
    }
}

struct PullRequestCompactCellView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestCompactCellView(
            model: .init(
                number: "123456",
                title: "title",
                author: .init(id: "1", name: "1d", avatarURL: defaultAvatarURL, color: nil),
                reviewers: [
                    .init(id: "1", name: "1d", avatarURL: defaultAvatarURL, color: nil),
                    .init(id: "1", name: "1d", avatarURL: defaultAvatarURL, color: nil)
                ]
            )
        )
    }
}

extension AvatarView.Model {
    static func reviewers(_ fragment: PullRequestFragment) -> [AvatarView.Model] {
        let reviewRequests: [AvatarView.Model]? = fragment.reviewRequests?.nodes?
            .compactMap { $0?.fragments.reviewRequestFragment.requestedReviewer?.fragments.actorFragment }
            .compactMap { .init($0, name: nil, color: nil) }

        let latestReviews: [AvatarView.Model]? = fragment.latestReviews?.nodes?
            .compactMap { $0?.fragments.pullRequestReviewFragment }
            .compactMap {
                guard let author = $0.author else { return nil }

                return .init(
                    author.fragments.actorFragment,
                    name: ($0.submittedAt?.date?.relativeAttributed).map { .init($0) },
                    color: $0.state.color
                )
            }

        var reviewers = OrderedSet<AvatarView.Model>()
        reviewRequests?.forEach { reviewers.updateOrAppend($0) }
        latestReviews?.forEach { reviewers.updateOrAppend($0) }

        return reviewers.filter { $0.color != nil } + reviewers.filter { $0.color == nil }
    }

    static func author(_ fragment: PullRequestFragment) -> AvatarView.Model? {
        guard let actor = fragment.author?.fragments.actorFragment else { return nil }

        return .init(
            actor,
            name: (fragment.createdAt.date?.relativeAttributed).map { .init($0) },
            color: fragment.isDraft ? .gray : nil
        )
    }

    func set(name: String?) -> Self {
        var result = self
        result.name = name.map { AttributedString($0) }
        return result
    }
}

extension PullRequestCellView.Model {
    init(_ fragment: PullRequestFragment) {
        self.init(
            number: String(fragment.number),
            title: fragment.title,
            author: AvatarView.Model.author(fragment),
            reviewers: AvatarView.Model.reviewers(fragment)
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
                number: "1234",
                title: "[AB-123] This is a PR for updating the user colors to the new ones that everyone wants dasd asds dsa",
                author: .init(
                    id: "1",
                    name: "10d",
                    avatarURL: defaultAvatarURL,
                    color: .gray
                ),
                reviewers: [
                    .init(
                        id: "1",
                        name: "1d",
                        avatarURL: defaultAvatarURL,
                        color: .red
                    ),
                    .init(
                        id: "2",
                        name: "2w",
                        avatarURL: defaultAvatarURL,
                        color: .orange
                    ),
                    .init(
                        id: "3",
                        name: "3y",
                        avatarURL: defaultAvatarURL,
                        color: .green
                    ),
                    .init(
                        id: "4",
                        avatarURL: defaultAvatarURL
                    )
                ]
            )
        )
    }
}
