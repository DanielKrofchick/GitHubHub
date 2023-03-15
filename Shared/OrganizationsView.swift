//
//  OrganizationsView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI
import Apollo

extension OrganizationsView {
    struct Model {
        struct Load {
            let login: String
        }
        struct Item: Identifiable {
            var id: String
            let link: RepositoriesView.Model
            let model: OrganizationCellView.Model
        }
        let load: Load
        let items: [Item]?
    }
}

struct OrganizationsView: View {
    @State var model: Model

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                RepositoriesView(model: item.link)
            } label: {
                OrganizationCellView(model: item.model)
            }
        }
        .navigationTitle("Organizations")
        .onAppear {
            loadData()
        }
    }
}

extension OrganizationsView {
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

private extension OrganizationsView.Model.Item {
    init(_ fragment: OrganizationFragment) {
        self.init(
            id: fragment.id,
            link: .init(
                load: .init(organization: fragment.login),
                title: fragment.login,
                items: nil,
                rateLimit: nil
            ),
            model: .init(fragment)
        )
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
