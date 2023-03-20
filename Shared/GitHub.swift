//
//  GitHub.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import Foundation
import Apollo

class GitHub {
    static let shared = GitHub()

    func user(_ login: String) async throws -> GraphQLResult<UserQuery.Data> {
        try await Network.shared.apollo.fetchAsync(
            query: UserQuery(login: login)
        )
    }

    func organizations(_ login: String) async throws -> GraphQLResult<OrganizationsQuery.Data> {
        try await Network.shared.apollo.fetchAsync(
            query: OrganizationsQuery(login: login)
        )
    }

    func repositories(_ login: String) async throws -> GraphQLResult<RepositoriesQuery.Data> {
        try await Network.shared.apollo.fetchAsync(
            query: RepositoriesQuery(login: login)
        )
    }

    func pullRequests(owner: String, name: String) async throws -> GraphQLResult<PullRequestsQuery.Data> {
        try await Network.shared.apollo.fetchAsync(
            query: PullRequestsQuery(owner: owner, name: name)
        )
    }

    func reviewers(owner: String, name: String, number: Int) async throws -> GraphQLResult<ReviewersQuery.Data> {
        try await Network.shared.apollo.fetchAsync(
            query: ReviewersQuery(owner: owner, name: name, number: number)
        )
    }


    func userPullRequests(login: String) async throws -> GraphQLResult<UserPullRequestsQuery.Data> {
        try await Network.shared.apollo.fetchAsync(
            query: UserPullRequestsQuery(login: login)
        )
    }
}
