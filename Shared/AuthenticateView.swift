//
//  AuthenticateView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-30.
//

import SwiftUI

extension AuthenticateView {
    struct Model {}
}

struct AuthenticateView: View {
    @State var model: Model
    @State private var token: String = Network.shared.token ?? ""
    @EnvironmentObject var navigation: NavigationCoordinator

    var body: some View {
        VStack {
            Text("GitHubHub")
                .font(.largeTitle)
            TextField("Token", text: $token)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .padding()
                .fixedSize()
            Button("Sign In") {
                Network.shared.token = token
                Self.doLogin(navigation)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        .padding()
    }
}

extension AuthenticateView {
    static func doLogin(_ navigation: NavigationCoordinator) {
        Task {
            do {
                let response = try await GitHub.shared.login()

                if let errors = response.errors {
                    throw errors
                }

                let login = response.data?.viewer.login

                Network.shared.login = login

                if let login {
                    navigation.push(.login(login))
                }
            } catch {
                print(error)
            }
        }
    }
}

