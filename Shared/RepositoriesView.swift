//
//  RepositoriesView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

struct RepositoriesView: View {
    struct Model {
        let avatars: [AvatarView.Model]
    }

    @State private var model: Model?

    let login: String

    var body: some View {
        List(model?.avatars ?? []) { avatar in
            NavigationLink {
            } label: {
                AvatarView(model: avatar)
            }
        }
        .navigationTitle("Repositories")
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let response = try await GitHub().repositories(login)

                if let errors = response.errors {
                    throw errors
                }

                let avatars = response.data?.organization?.repositories.nodes?
                    .compactMap { $0?.fragments.repositoryFragment }
                    .map { AvatarView.Model($0) }
                model = avatars.map { Model(avatars: $0) }
            } catch {
                print(error)
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView(login: defaultLogin)
    }
}
