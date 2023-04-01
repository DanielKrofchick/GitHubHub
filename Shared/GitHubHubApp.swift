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
            ZStack(alignment: .topTrailing) {
                NavigationStack(path: $navigation.path) {
                    AuthenticateView(model: .init())
                        .navigationDestination(for: Destination.self) { destination in
                            switch destination {
                            case .login(let login):
                                HomeView(model: .init(load: .init(login: login), avatar: nil))
                            }
                        }
                        .onAppear {
                            if Network.shared.token != nil {
                                AuthenticateView.doLogin(navigation)
                            }
                        }
                }
                RateLimitView()
            }
            .environmentObject(navigation)
            .environmentObject(rateLimit)
        }
    }
}

struct RateLimitView: View {
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        if let text = rateLimit.text {
            Text(text)
                .font(.body)
                .padding()
                .background(.red)
        }
    }
}
