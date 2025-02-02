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
        let avatar: AvatarView.Model
        let name: String?
        let backgroundColor: Color?
        let count: String?
        let organization: String?
        let rateLimit: String?
    }
}

struct ReviewerCellView: View {
    @State var model: Model
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        HStack {
            AvatarView(model: model.avatar, size: 50)
                .border(model.backgroundColor ?? .clear)
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
        .onAppear {
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
                    organization: organization,
                    rateLimit: response.data?.rateLimit?.fragments.rateLimitFragment.description
                )

                if let rateLimit = model.rateLimit {
                    self.rateLimit.text = rateLimit
                }
            } catch {
                print(error)
            }
        }
    }
}
