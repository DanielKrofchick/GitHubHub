//
//  AvatarView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

struct AvatarView: View {
    struct Model {
        let name: String?
        let avatarURL: URL?
    }

    @State var model: Model

    var body: some View {
        VStack {
            AsyncImage(
                url: model.avatarURL,
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
            Text(model.name ?? " ")
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(model: .init(name: "name", avatarURL: nil))
    }
}
