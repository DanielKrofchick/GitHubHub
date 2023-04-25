//
//  NavigationCoordinator.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-31.
//

import SwiftUI

enum Destination: Hashable {
    case login(_ login: String)
    case organizations(_ login: String)
}

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ destination: Destination) {
        path.append(destination)
    }
}
