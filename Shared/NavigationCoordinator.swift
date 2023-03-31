//
//  NavigationCoordinator.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-31.
//

import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func pushLogin(login: String) {
        path.append(Destination.login(login))
    }
}
