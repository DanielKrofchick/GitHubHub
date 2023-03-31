//
//  AuthenticateView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-30.
//

import SwiftUI

extension AuthenticateViewContent {
    struct Model {
        struct Load {
        }
    }
}

struct AuthenticateViewContent: View {
    enum FocusedField {
        case login
        case token
    }

    @State var model: Model
    @State private var token: String = ""
    @FocusState private var focusedField: FocusedField?
    @EnvironmentObject var coordinator: NavigationCoordinator

    var body: some View {
        VStack {
            Text("GitHubHub")
                .font(.largeTitle)
            TextField("Token", text: $token)
                .focused($focusedField, equals: .token)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .border(.primary)
            Button("Sign In") {
                Network.shared.token = token
                Self.doLogin(coordinator)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        .padding()
    }
}

extension AuthenticateViewContent {
    static func doLogin(_ coordinator: NavigationCoordinator) {
        Task {
            do {
                let response = try await GitHub.shared.login()

                if let errors = response.errors {
                    throw errors
                }

                if let login = response.data?.viewer.login {
                    coordinator.pushLogin(login: login)
                }
            } catch {
                print(error)
            }
        }
    }
}

