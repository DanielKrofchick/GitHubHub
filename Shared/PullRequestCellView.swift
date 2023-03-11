//
//  PullRequestCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-10.
//

import SwiftUI
import OrderedCollections

struct PullRequestCellView: View {
    struct Model {
        let title: String?
        let author: AvatarView.Model?
        let age: String?
        let reviewers: [AvatarView.Model]?
    }

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
                HStack {
                    ForEach(model.reviewers ?? []) {
                        AvatarView(model: $0, size: 20)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

extension PullRequestCellView.Model {
    init(_ fragment: PullRequestFragment) {
        let reviewRequests = fragment.reviewRequests?.nodes?
            .compactMap { $0?.fragments.reviewRequestFragment.requestedReviewer?.fragments.actorFragment }
            .compactMap { AvatarView.Model.init($0) }
        let latestReviews = fragment.latestReviews?.nodes?
            .compactMap { $0?.fragments.pullRequestReviewFragment }
            .compactMap { AvatarView.Model.init($0) }

        var reviewers = OrderedSet<AvatarView.Model>()
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
            reviewers: reviewers.filter { $0.color != nil } + reviewers.filter { $0.color == nil }
        )
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
                        id: "1",
                        avatarURL: defaultAvatarURL,
                        color: .red
                    ),
                    .init(
                        id: "2",
                        avatarURL: defaultAvatarURL,
                        color: .green
                    ),
                    .init(
                        id: "3",
                        avatarURL: defaultAvatarURL
                    )
                ]
            )
        )
    }
}
