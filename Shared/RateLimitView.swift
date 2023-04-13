//
//  RateLimitView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-04-12.
//

import SwiftUI

struct RateLimitView: View {
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        if let text = rateLimit.text {
            Text(text)
                .font(.body)
                .padding(5)
//                .background(Color(white: 0.95))
                .cornerRadius(10)
                .padding(5)
        }
    }
}
