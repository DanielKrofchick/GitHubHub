//
//  ReviewerCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-19.
//

import SwiftUI
import OrderedCollections

extension ReviewerCellView {
    struct Model {
        let avatar: AvatarAgeView.Model
        let name: String?
        let backgroundColor: Color?
        let count: String?
        let organization: String?
    }
}

struct ReviewerCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            AvatarAgeView(model: model.avatar, size: 50)
            Spacer(minLength: 15)
            if let name = model.name {
                Text(name)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let count = model.count {
                Text(count)
                    .font(.body)
                    .frame(alignment: .trailing)
            }
        }
        .background(model.backgroundColor)
        .onAppear {
            return;

            if let organization = model.organization {
                loadPullRequestCountData(login: model.avatar.id, organization: organization)
            }
        }
    }
}

extension ReviewerCellView {
    private func loadPullRequestCountData(login: String, organization: String) {
        Task {
            do {
                let response = try await GitHub.shared.userPullRequests(login: login)

                if let errors = response.errors { throw errors }

                let count =  (response.data?.pullRequests(organization: organization)?.count).map { String($0) }

                guard count != model.count else { return }

                model = Model(
                    avatar: model.avatar,
                    name: model.name,
                    backgroundColor: model.backgroundColor,
                    count: count,
                    organization: organization
                )
            } catch {
                print(error)
            }
        }
    }
}
