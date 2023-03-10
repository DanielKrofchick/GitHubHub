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
        let color: Color?

        init(id: String, name: String? = nil, avatarURL: URL? = nil, color: Color? = nil) {
            self.id = id
            self.name = name
            self.avatarURL = avatarURL
            self.color = color
        }
    }

    @State var model: Model
    @State var size: CGFloat = 40

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
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .shadow(radius: 7)
                .padding(10)
                .background(model.color)
            }
            if let name = model.name {
                Text(name)
            }
        }
    }
}

extension AvatarView.Model {
    init(_ fragment: ActorFragment, color: Color? = nil, hasName: Bool = false) {
        self.init(
            id: fragment.login,
            name: hasName ? fragment.login : nil,
            avatarURL: URL(string: fragment.avatarUrl),
            color: color
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
            id: fragment.name,
            name: fragment.name
        )
    }

    init(_ fragment: PullRequestFragment) {
        self.init(
            id: fragment.id,
            name: fragment.title,
            color: fragment.isDraft ? .gray : nil
        )
    }

    init?(_ fragment: PullRequestReviewFragment) {
        guard let actorFragment = fragment.author?.fragments.actorFragment else { return nil }

        self.init(
            actorFragment,
            color: fragment.state.color
        )
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(
            model: .init(
                id: "1",
                avatarURL: defaultAvatarURL,
                color: .orange
            )
        )
    }
}
