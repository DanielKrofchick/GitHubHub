//
//  HomeView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

struct HomeView: View {
    struct Model {
        struct Load {
            let login: String
        }
        let load: Load
        let avatar: AvatarView.Model?
    }

    @State var model: Model

    var body: some View {
        VStack {
            if let avatar = model.avatar {
                AvatarView(model: avatar)
            }
        }
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let response = try await GitHub().user(model.load.login)

                if let errors = response.errors {
                    throw errors
                }

                model = .init(
                    load: model.load,
                    avatar: (response.data?.user?.fragments.userFragment)
                        .map { .init($0) }
                )
            } catch {
                print(error)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(model: .init(load: .init(login: defaultLogin), avatar: nil))
    }
}
