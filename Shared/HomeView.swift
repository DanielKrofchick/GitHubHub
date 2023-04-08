//
//  HomeView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

extension HomeView {
    struct Model: Equatable {
        struct Load: Equatable {
            let login: String
        }
        let load: Load
        let avatar: AvatarView.Model?
    }
}

extension HomeView: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(model.load.login)
        hasher.combine(model.avatar)
    }
}

struct HomeView: View {
    static func == (lhs: HomeView, rhs: HomeView) -> Bool {
        lhs.model == rhs.model
    }

    @State var model: Model

    var body: some View {
        VStack {
            Spacer()
            if let avatar = model.avatar {
                NavigationLink {
                    OrganizationsView(model: .init(load: .init(login: model.load.login), items: nil))
                } label: {
                    AvatarView(model: avatar, size: 100)
                }
                .buttonStyle(PlainButtonStyle())
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            loadData()
        }
    }
}

extension HomeView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub.shared.user(model.load.login)

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
