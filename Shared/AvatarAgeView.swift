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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack(spacing: 0) {
            AvatarView(model: model.avatar, size: size)
                .frame(alignment: .top)
            if let age = model.age {
                if horizontalSizeClass == .compact {
                    Text(age)
                        .padding(0)
                } else {
                    Text(age)
                        .font(.system(size: 12, weight: .semibold))
                        .frame(height: 20)
                        .lineLimit(1)
                        .padding(0)
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
