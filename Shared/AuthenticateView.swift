//
//  AuthenticateView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-30.
//

import SwiftUI

extension AuthenticateView {
    struct Model {
        struct Load {
        }
    }
}

struct AuthenticateView: View {
    enum FocusedField {
        case login
        case token
    }

    @State var model: Model
    @State private var token: String = ""
    @FocusState private var focusedField: FocusedField?
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack {
            Text("GitHubHub")
                .font(.largeTitle)
            TextField("Token", text: $token)
                .focused($focusedField, equals: .token)
                .onSubmit {}
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .border(.primary)
            Button("Sign In") {
                Network.shared.token = token
                doLogin()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        .padding()
    }
}

extension AuthenticateView {
    private func doLogin() {
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

