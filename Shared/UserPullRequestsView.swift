//
//  UserPullRequests.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-19.
//

import SwiftUI
import Apollo

extension UserPullRequestsView {
    struct Model {
        struct Load {
            let login: String
            let organization: String?
            let repository: String?
        }
        struct Item: Identifiable {
            let id: String
            let link: ReviewersView.Model
            let model: PullRequestCellView.Model
        }
        let load: Load
        let title: String?
        let items: [Item]?
        let rateLimit: String?
    }
}

struct UserPullRequestsView: View {
    @State var model: Model
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        List(model.items ?? []) { item in
            NavigationLink {
                ReviewersView(model: item.link)
            } label: {
                PullRequestCellView(model: item.model)
            }
        }
        .navigationTitle(model.title ?? "")
        .onAppear {
            loadData()
        }
    }
}

extension UserPullRequestsView {
    private func loadData() {
        Task {
            do {
                let response = try await GitHub().userPullRequests(login: model.load.login)

                if let errors = response.errors {
                    throw errors
                }

                model = .init(response.data, load: model.load)

                if let rateLimit = model.rateLimit {
                    self.rateLimit.text = rateLimit
                }
            } catch {
                print(error)
            }
        }
    }
}

struct UserPullRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsView(
            model: .init(
                load: .init(
                    organization: defaultOrganization,
                    repository: defaultRepository,
                    isCompact: false
                ),
                title: nil,
                items: nil,
                rateLimit: nil
            )
        )
    }
}

extension UserPullRequestsView.Model {
    init(_ data: UserPullRequestsQuery.Data?, load: Load) {
        self.init(
            load: load,
            title: data?.user?.login,
            items: data?.pullRequests(
                organization: load.organization,
                repository: load.repository
            )?.map { UserPullRequestsView.Model.Item($0) },
            rateLimit: data?.rateLimit?.fragments.rateLimitFragment.description ?? ""
        )
    }
}

extension [PullRequestFragment] {
    func filter(organization: String?, repository: String?) -> [Element] {
        self.filter { item in
            let isOrganization = organization.map { item.repository.owner.login == $0 } ?? true
            let isRepository = repository.map { item.repository.name == $0 } ?? true

            return isOrganization && isRepository
        }
    }
}

extension UserPullRequestsQuery.Data {
    func pullRequests(organization: String? = nil, repository: String? = nil) -> [PullRequestFragment]? {
        user?.pullRequests.nodes?
            .compactMap { $0?.fragments.pullRequestFragment }
            .filter(
                organization: organization,
                repository: repository
            )
            .reversed()
    }
}

extension UserPullRequestsView.Model {
    init(_ model: AvatarView.Model, organization: String, repository: String) {
        self.init(
            load: .init(
                login: model.id,
                organization: organization,
                repository: repository
            ),
            title: model.name.map { String($0.characters[...]) },
            items: nil,
            rateLimit: nil
        )
    }
}

private extension UserPullRequestsView.Model.Item {
    init(_ fragment: PullRequestFragment) {
        self.init(
            id: fragment.id,
            link: ReviewersView.Model(fragment),
            model: PullRequestCellView.Model(fragment)
        )
    }
}
