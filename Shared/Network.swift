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

class Network {
    static let shared = Network()
    private let domain = "https://api.github.com/graphql"
    private let token = "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"

    private(set) lazy var apollo: ApolloClient = {
        let store = ApolloStore()
        return ApolloClient(
            networkTransport: RequestChainNetworkTransport(
                interceptorProvider: DefaultInterceptorProvider(store: store),
                endpointURL: URL(string: domain)!,
                additionalHeaders: headers
            ),
            store: store
        )
    }()

    private lazy var headers: [String: String] = [
        "Authorization": "bearer \(token)"
    ]
}
