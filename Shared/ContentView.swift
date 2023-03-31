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

struct ContentView: View {
    @State var login: String
    @ObservedObject var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            AuthenticateView(model: .init())
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .login(let login):
                        HomeView(model: .init(load: .init(login: login), avatar: nil))
                    }
                }
        }
        .environmentObject(coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(login: defaultLogin)
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func pushLogin(login: String) {
        path.append(Destination.login(login))
    }
}
