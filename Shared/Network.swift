//
//  Network.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-13.
//

import Foundation
import Apollo
import SwiftUI
import KeychainStored

class Network {
    static let shared = Network()
    private let domain = "https://api.github.com/graphql"

    @KeychainStored(service: "Network.login") var login: String?
    @KeychainStored(service: "Network.token") var token: String? {
        didSet {
            apollo = makeClient()
        }
    }

    private(set) lazy var apollo: ApolloClient = {
        makeClient()
    }()

    func makeClient() -> ApolloClient {
        let store = ApolloStore()
        return ApolloClient(
            networkTransport: RequestChainNetworkTransport(
                interceptorProvider: DefaultInterceptorProvider(store: store),
                endpointURL: URL(string: domain)!,
                additionalHeaders: headers
            ),
            store: store
        )
    }

    private var headers: [String: String] {
        [
            "Authorization": "bearer \(token ?? "")"
        ]
    }
}
