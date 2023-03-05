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

    func user(_ user: String) async throws -> GraphQLResult<UserQuery.Data> {
        try await Network.shared.apollo
            .fetchAsync(query: UserQuery(login: user))
    }

    func organizations(_ user: String) async throws -> GraphQLResult<OrganizationsQuery.Data> {
        try await Network.shared.apollo
            .fetchAsync(query: OrganizationsQuery(login: user))
    }
}
