//
//  GitHubHubApp.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

let defaultLogin = "DanielKrofchick"
let defaultOrganization = "carmigo"
let defaultRepository = "eblock-ios"
let defaultPullRequest = 1950
let defaultAvatarURL = URL(string: "https://avatars.githubusercontent.com/u/3325828?v=4")

@main
struct GitHubHubApp: App {
    @ObservedObject var coordinator = NavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                AuthenticateView(model: .init())
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .login(let login):
                            HomeView(model: .init(load: .init(login: login), avatar: nil))
                        }
                    }
                    .onAppear {
                        if Network.shared.token != nil {
                            AuthenticateView.doLogin(coordinator)
                        }
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
