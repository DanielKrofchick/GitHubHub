//
//  AvatarView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

struct AvatarView: View {
    struct Model: Identifiable, Hashable, Equatable {
        let id: String
        var name: AttributedString?
        let avatarURL: URL?
        let color: Color?

        init(
            id: String,
            name: AttributedString? = nil,
            avatarURL: URL? = nil,
            color: Color? = nil
        ) {
            self.id = id
            self.name = name
            self.avatarURL = avatarURL
            self.color = color
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }

    @State var model: Model
    @State var size: CGFloat = 50

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
                .padding(4)
                .background(model.color)
            }
            if let name = model.name {
                Text(name)
            }
        }
    }
}

struct Box<T> {
    var wrapped: T

    init(_ wrapped: T) {
        self.wrapped = wrapped
    }
}

extension AvatarView.Model {
    init(
        _ fragment: ActorFragment,
        // a bit silly, Box is used to have a default state and allow overriding it with all values including nil
        name: Box<AttributedString?>? = .init(nil),
        color: Color? = nil
    ) {
        self.init(
            id: fragment.login,
            name: name.map { $0.wrapped ?? AttributedString(fragment.login) },
            avatarURL: URL(string: fragment.avatarUrl),
            color: color
        )
    }
    
    init(
        _ fragment: OrganizationFragment,
        name: Box<String?>? = .init(nil)
    ) {
        self.init(
            id: fragment.id,
            name: name.map { AttributedString($0.wrapped ?? fragment.login) },
            avatarURL: URL(string: fragment.avatarUrl)
        )
    }

    init(_ fragment: RepositoryFragment) {
        self.init(
            id: fragment.name,
            name: AttributedString(fragment.name)
        )
    }

    init(_ fragment: PullRequestFragment) {
        self.init(
            id: fragment.id,
            name: AttributedString(fragment.title),
            color: fragment.isDraft ? .gray : nil
        )
    }

    init?(
        fragment: PullRequestReviewFragment,
        name: Box<String?>? = .init(nil)
    ) {
        guard let actorFragment = fragment.author?.fragments.actorFragment else { return nil }

        self.init(
            actorFragment,
            name: name.map {
                if let wrapped = $0.wrapped {
                    return .init(AttributedString(wrapped))
                } else {
                    return .init(nil)
                }
            },
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
