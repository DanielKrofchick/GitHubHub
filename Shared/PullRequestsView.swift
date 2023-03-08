//
//  PullRequestsView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-07.
//

import SwiftUI
import Apollo

struct PullRequestsView: View {
    struct Model {
        let avatars: [AvatarView.Model]
    }

    struct InitModel {
        let owner: String
        let name: String
    }

    @State private var model: Model?
    let initModel: InitModel

    var body: some View {
        List(model?.avatars ?? []) { avatar in
            NavigationLink {
            } label: {
                AvatarView(model: avatar)
            }
        }
        .navigationTitle("Pull Requests")
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let response = try await GitHub().pullRequests(owner: initModel.owner, name: initModel.name)

                if let errors = response.errors {
                    throw errors
                }

                let avatars = response.data?.repository?.pullRequests.nodes?
                    .compactMap { $0?.fragments.pullRequestFragment }
                    .map { AvatarView.Model($0) }
                model = avatars.map { Model(avatars: $0) }
            } catch {
                print(error)
            }
        }
    }
}

struct PullRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsView(initModel: .init(owner: defaultOrganization, name: defaultORepository))
    }
}
