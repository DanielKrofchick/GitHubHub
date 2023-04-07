//
//  AvatarAgeView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-14.
//

import SwiftUI

struct AvatarAgeView: View {
    @State var model: Model
    @State var size: CGFloat = 40
    #if targetEnvironment (macCatalyst)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif

    var body: some View {
        VStack(spacing: 0) {
            AvatarView(model: model.avatar, size: size)
                .frame(alignment: .top)
            if let age = model.age {
                var isCompact = false
                #if targetEnvironment (macCatalyst)
                isCompact = horizontalSizeClass = .compact
                #endif
                if isCompact {
                    Text(age)
                        .padding(0)
                } else {
                    Text(age)
                        .font(.system(size: 12, weight: .semibold))
                        .lineLimit(1)
                        .padding(0)
                        .scaledToFill()
                }
            }
        }
        
    }
}

extension AvatarAgeView {
    struct Model: Hashable, Identifiable {
        var id: String { avatar.id }
        let avatar: AvatarView.Model
        let age: AttributedString?

        func hash(into hasher: inout Hasher) {
            hasher.combine(avatar)
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.avatar.id == rhs.avatar.id
        }
    }
}
