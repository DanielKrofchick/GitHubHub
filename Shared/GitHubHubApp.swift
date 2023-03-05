//
//  GitHubHubApp.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

let defaultLogin = "DanielKrofchick"

@main
struct GitHubHubApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(login: defaultLogin)
        }
    }
}
