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
    var body: some Scene {
        WindowGroup {
            AuthenticateView()
        }
    }
}
