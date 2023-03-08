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
        struct Load {
            let login: String
        }
        struct Item: Identifiable {
            var id: String { avatar.id }
            let load: PullRequestsView.Model
            let avatar: AvatarView.Model
        }
        let load: Load
        let items: [Item]?
    }

    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                PullRequestsView(model: item.load)
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
                let response = try await GitHub().repositories(model.load.login)

                if let errors = response.errors {
                    throw errors
                }

                model = .init(
                    load: model.load,
                    items: response.data?.organization?.repositories.nodes?
                        .compactMap { $0?.fragments.repositoryFragment }
                        .map { RepositoriesView.Model.Item($0) }
                )
            } catch {
                print(error)
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView(
            model: .init(
                load: .init(login: defaultLogin),
                items: nil
            )
        )
    }
}

private extension RepositoriesView.Model.Item {
    init(_ fragment: RepositoryFragment) {
        self.init(
            load: .init(
                load: .init(
                    owner: fragment.owner.login,
                    name: fragment.name
                ),
                items: nil
            ),
            avatar: .init(fragment)
        )
    }
}
