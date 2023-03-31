//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

enum Destination: Hashable {
    case login(_ login: String)
}

struct AuthenticateView: View {
    @ObservedObject var coordinator = NavigationCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            AuthenticateViewContent(model: .init())
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .login(let login):
                        HomeView(model: .init(load: .init(login: login), avatar: nil))
                    }
                }
                .onAppear {
                    if Network.shared.token != nil {
                        AuthenticateViewContent.doLogin(coordinator)
                    }
                }
        }
        .environmentObject(coordinator)
    }
}

struct Authenticate_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
    }
}
