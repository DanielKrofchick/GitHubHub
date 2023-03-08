//
//  OrganizationsView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI
import Apollo

struct OrganizationsView: View {
    struct Model {
        struct Load {
            let login: String
        }
        struct Item: Identifiable {
            var id: String { avatar.id }
            let load: RepositoriesView.Model
            let avatar: AvatarView.Model
        }
        let load: Load
        let items: [Item]?
    }

    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                RepositoriesView(model: item.load)
            } label: {
                AvatarView(model: item.avatar)
            }
        }
        .navigationTitle("Organizations")
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let response = try await GitHub().organizations(model.load.login)

                if let errors = response.errors {
                    throw errors
                }

                model = .init(
                    load: model.load,
                    items: response.data?.user?.organizations.nodes?
                        .compactMap { $0?.fragments.organizationFragment }
                        .map { Model.Item($0) }
                )
            } catch {
                print(error)
            }
        }
    }
}

struct OrganizationsView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationsView(
            model: .init(
                load: .init(login: defaultLogin),
                items: nil
            )
        )
    }
}

private extension OrganizationsView.Model.Item {
    init(_ fragment: OrganizationFragment) {
        self.init(
            load: .init(
                load: .init(login: fragment.login),
                items: nil
            ),
            avatar: .init(fragment)
        )
    }
}

