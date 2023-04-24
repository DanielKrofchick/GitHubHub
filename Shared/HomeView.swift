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
        let rateLimit: String?
    }
}

struct HomeView: View {
    @State var model: Model
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        LoadingView(loader: self) {
            VStack {
                Spacer()
                if let avatar = model.avatar {
                    NavigationLink {
                        OrganizationsView(model.load.login)
                    } label: {
                        AvatarView(model: avatar, size: 100)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension HomeView {
    init(_ login: String) {
        self.init(model: .init(load: .init(login: login), avatar: nil, rateLimit: nil))
    }
}

extension HomeView: Loadable {
    func load() async throws {
        let response = try await GitHub.shared.user(model.load.login)
        
        if let errors = response.errors {
            throw errors
        }
        
        model = Model(response.data, load: model.load)

        if let rateLimit = model.rateLimit {
            self.rateLimit.text = rateLimit
        }
    }
}

extension HomeView.Model {
    init(_ data: UserQuery.Data?, load: Load) {
        self.init(
            load: load,
            avatar: (data?.user?.fragments.actorFragment)
                .map { .init($0) },
            rateLimit: data?.rateLimit?.fragments.rateLimitFragment.description
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            model: .init(
                load: .init(login: defaultLogin),
                avatar: nil,
                rateLimit: nil
            )
        )
    }
}
