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
    @ObservedObject var navigation = NavigationCoordinator()
    @ObservedObject var rateLimit = RateLimitCoordinator()

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottomTrailing) {
                NavigationStack(path: $navigation.path) {
                    Spacer()
                    AuthenticateView(model: .init())
                        .navigationDestination(for: Destination.self) { destination in
                            switch destination {
                            case .login(let login):
                                HomeView(login)
                            }
                        }
                        .onAppear {
                            if Network.shared.token != nil {
                                AuthenticateView.doLogin(navigation)
                            }
                        }
                    Spacer()
                }
                RateLimitView()
            }
            .environmentObject(navigation)
            .environmentObject(rateLimit)
        }
    }
}
