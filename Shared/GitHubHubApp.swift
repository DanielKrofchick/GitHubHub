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
    @State var isOn = true

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.path) {
                Spacer()
                AuthenticateView(model: .init())
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .login(let login):
                            HomeView(login)
                        case .organizations(let login):
                            OrganizationsView(login)
                        }
                    }
                    .task {
                        if Network.shared.token != nil {
                            if let login = Network.shared.login {
                                navigation.push(.login(login))
                                navigation.push(.organizations(login))
                            } else {
                                AuthenticateView.doLogin(navigation)
                            }
                        }
                    }
                Spacer()
            }
            .toolbar {
                Toggle(isOn: $isOn) {
                    RateLimitView()
                }
            }
            .environmentObject(navigation)
            .environmentObject(rateLimit)
        }
    }
}
