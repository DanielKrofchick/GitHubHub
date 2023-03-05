//
//  ApolloClient+.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-16.
//

import Apollo

extension [GraphQLError]: Error {}

extension ApolloClient {
    func fetchAsync<Query: GraphQLQuery>(query: Query) async throws -> GraphQLResult<Query.Data> {
        try await withCheckedThrowingContinuation { continuation in
            fetch(query: query) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func performAsync<Mutation: GraphQLMutation>(mutation: Mutation) async throws -> GraphQLResult<Mutation.Data> {
        try await withCheckedThrowingContinuation { continuation in
            perform(mutation: mutation) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
