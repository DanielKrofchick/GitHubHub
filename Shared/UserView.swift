//
//  UserView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-16.
//

import SwiftUI

struct UserView: View {
    var name: String

    var body: some View {
        Text(name)
            .padding()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(name: "Boba Fett")
    }
}

extension UserView {
    init(_ data: UserFragment) {
        name = data.name ?? "BBB"
    }
}
