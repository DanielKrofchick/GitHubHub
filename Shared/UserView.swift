//
//  UserView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-16.
//

import SwiftUI

struct UserView: View {
    let name: String?
    let avatarURL: URL?

    var body: some View {
        VStack {
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
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.gray, lineWidth: 4)
                }
                .shadow(radius: 7)
            Text(name ?? "")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(
            name: "Boba Fett",
            avatarURL: nil
        )
    }
}

extension UserView {
    init(_ data: UserFragment) {
        name = data.name
        avatarURL = URL(string: data.avatarUrl)
    }
}
