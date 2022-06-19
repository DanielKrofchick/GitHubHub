//
//  UserView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-16.
//

import SwiftUI

struct UserView: View {
    @State private var name: String?
    @State private var avatarURL: URL?
    private let login: String

    init(_ login: String) {
        self.login = login
    }

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
            Text(name ?? " ")
        }
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let user = try await GitHub().user(login)
                if let fragment = user.data?.user?.fragments.userFragment {
                    bind(fragment)
                }
            } catch {
                print(error)
            }
        }
    }

    private func bind(_ fragment: UserFragment) {
        name = fragment.name
        avatarURL = URL(string: fragment.avatarUrl)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView("DanielKrofchick")
    }
}
