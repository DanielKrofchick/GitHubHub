//
//  AvatarView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

struct AvatarView: View {
    struct Model: Identifiable {
        let id: String
        let name: String?
        let avatarURL: URL?
    }

    @State var model: Model

    var body: some View {
        VStack {
            if let avatarURL = model.avatarURL {
                AsyncImage(
                    url: avatarURL,
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.gray, lineWidth: 4)
                }
                .shadow(radius: 7)
            }
            Text(model.name ?? " ")
        }
    }
}

extension AvatarView.Model {
    init(_ fragment: UserFragment) {
        self.init(
            id: fragment.id,
            name: fragment.login,
            avatarURL: URL(string: fragment.avatarUrl)
        )
    }

    init(_ fragment: OrganizationFragment) {
        self.init(
            id: fragment.id,
            name: fragment.login,
            avatarURL: URL(string: fragment.avatarUrl)
        )
    }

    init(_ fragment: RepositoryFragment) {
        self.init(
            id: fragment.id,
            name: fragment.name,
            avatarURL: nil
        )
    }

    init(_ fragment: PullRequestFragment) {
        self.init(
            id: fragment.id,
            name: fragment.title,
            avatarURL: nil
        )
    }

    init(_ fragment: ReviewerFragment) {
        self.init(
            id: fragment.id,
            name: fragment.login,
            avatarURL: URL(string: fragment.avatarUrl)
        )
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(
            model: .init(
                id: "1",
                name: "name",
                avatarURL: nil
            )
        )
    }
}
