//
//  RateLimitFragment+.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-04-01.
//

import Foundation

extension RateLimitFragment {
    var description: String {
        "\(remaining) - \(resetAt.date?.relative ?? "")"
    }
}
