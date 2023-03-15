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

    var body: some View {
        VStack {
            AvatarView(model: model.avatar, size: size)
                .frame(alignment: .top)
            if let age = model.age {
                Text(age)
            }
        }
    }
}

extension AvatarAgeView {
    struct Model: Hashable, Identifiable {
        var id: String { avatar.id }
        let avatar: AvatarView.Model
        let age: String?

        func hash(into hasher: inout Hasher) {
            hasher.combine(avatar)
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.avatar.id == rhs.avatar.id
        }
    }
}
