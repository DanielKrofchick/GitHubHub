////
////  Network.swift
////  GitHubHub
////
////  Created by Daniel Krofchick on 2022-06-13.
////
//
//import Foundation
//import Apollo
//
//class Network {
//    static let shared = Network()
//    let domain = "https://api.github.com/graphql"
//
//    private(set) lazy var apollo = ApolloClient(url: URL(string: domain)!)
//}

//
//  Network.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-13.
//

import Foundation
import Apollo

// token = "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"

class Network {
    static let shared = Network()
    private let domain = "https://api.github.com/graphql"

    var token: String = "" {
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
            "Authorization": "bearer \(token)"
        ]
    }
}
