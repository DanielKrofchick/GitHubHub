//
//  HomeView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-04.
//

import SwiftUI

struct HomeView: View {
    struct Model {
        let avatar: AvatarView.Model
    }

    @State private var model: Model?

    let login: String

    var body: some View {
        VStack {
            if let model {
                AvatarView(model: model.avatar)
            }
        }
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        Task {
            do {
                let response = try await GitHub().user(login)

                if let errors = response.errors {
                    throw errors
                }

                if let fragment = response.data?.user?.fragments.userFragment {
                    model = .init(avatar: .init(fragment))
                }
            } catch {
                print(error)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(login: defaultLogin)
    }
}
