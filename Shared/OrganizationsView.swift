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
        let avatars: [AvatarView.Model]
    }

    @State private var model: Model?

    let login: String

    var body: some View {
        List(model?.avatars ?? []) { avatar in
            NavigationLink {
                RepositoriesView(model: .init(load: .init(login: avatar.login), items: nil))
            } label: {
                AvatarView(model: avatar)
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
                let response = try await GitHub().organizations(login)

                if let errors = response.errors {
                    throw errors
                }

                let avatars = response.data?.user?.organizations.nodes?
                    .compactMap { $0?.fragments.organizationFragment }
                    .map { AvatarView.Model($0) }
                model = avatars.map { Model(avatars: $0) }
            } catch {
                print(error)
            }
        }
    }
}

struct OrganizationsView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationsView(login: defaultLogin)
    }
}
