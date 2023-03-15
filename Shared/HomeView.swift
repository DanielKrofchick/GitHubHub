//
//  HomeView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

extension HomeView {
    struct Model {
        struct Load {
            let login: String
        }
        let load: Load
        let avatar: AvatarView.Model?
    }
}

struct HomeView: View {
    @State var model: Model

    var body: some View {
        VStack {
            if let avatar = model.avatar {
                AvatarView(model: avatar, size: 100)
            }
        }
        .onAppear {
            loadData()
        }
    }
}

extension HomeView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub().user(model.load.login)

                if let errors = response.errors {
                    throw errors
                }

                model = Model(response.data, load: model.load)
            } catch {
                print(error)
            }
        }
    }
}

extension HomeView.Model {
    init(_ data: UserQuery.Data?, load: Load) {
        self.init(
            load: load,
            avatar: (data?.user?.fragments.actorFragment)
                .map { .init($0, hasName: true) }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            model: .init(
                load: .init(login: defaultLogin),
                avatar: nil
            )
        )
    }
}
