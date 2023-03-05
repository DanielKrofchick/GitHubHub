//
//  HomeView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

struct HomeView: View {
    struct Model {
        let avatar: AvatarView.Model
    }

    @State private var model: Model?

    let login: String

    var body: some View {
        VStack {
            if let model {
                AvatarView(model: model.avatar)
            }
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
                    model = .init(avatar: .init(fragment))
                }
            } catch {
                print(error)
            }
        }
    }
}

extension AvatarView.Model {
    init(_ fragment: UserFragment) {
        self.init(
            name: fragment.name,
            avatarURL: URL(string: fragment.avatarUrl)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(login: "DanielKrofchick")
    }
}
