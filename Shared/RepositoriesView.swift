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
        struct Item: Identifiable {
            var id: String { avatar.id }
            let initModel: PullRequestsView.InitModel
            let avatar: AvatarView.Model
        }
        let items: [Item]
    }

    @State private var model: Model?

    let login: String

    var body: some View {
        List(model?.items ?? []) { item in
            NavigationLink {
                PullRequestsView(initModel: item.initModel)
            } label: {
                AvatarView(model: item.avatar)
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
                    .map { RepositoriesView.Model.Item($0) }
                model = avatars.map { Model(items: $0) }
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

private extension RepositoriesView.Model.Item {
    init(_ fragment: RepositoryFragment) {
        self.init(
            initModel: .init(
                owner: fragment.owner.login,
                name: fragment.name
            ),
            avatar: .init(fragment)
        )
    }
}
