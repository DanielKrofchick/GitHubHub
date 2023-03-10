//
//  PullRequestCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-10.
//

import SwiftUI

struct PullRequestCellView: View {
    struct Model {
        let title: String?
        let author: AvatarView.Model?
        let reviewers: [AvatarView.Model]?
    }

    @State var model: Model

    var body: some View {
        HStack {
            if let author = model.author {
                AvatarView(model: author)
            }
            VStack {
                if let title = model.title {
                    Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .border(.green)
                }
                HStack {
                    ForEach(model.reviewers ?? []) {
                        AvatarView(model: $0, size: .init(width: 30, height: 30))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .border(.yellow)
            }
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
