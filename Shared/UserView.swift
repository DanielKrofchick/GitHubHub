//
//  UserView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-16.
//

import SwiftUI

struct UserView: View {
    struct Model {
        let name: String?
    }

   @State var user: Model

    var body: some View {
        Text(user.name ?? "-")
            .padding()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: .init(name: "Boba Fett"))
    }
}

extension UserView.Model {
    init(_ data: UserFragment) {
        name = data.name
    }
}
