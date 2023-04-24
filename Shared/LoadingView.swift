//
//  LoadingView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-04-21.
//

import SwiftUI

protocol Refreshable {
    func refresh() async throws
}

struct LoadingView<Loader, Content>: View where Loader: Refreshable, Content: View {
    let loader: Refreshable
    let content: Content

    init(loader: Loader, @ViewBuilder _ content: () -> Content) {
        self.loader = loader
        self.content = content()
    }

    @State private var isLoading = false
    @EnvironmentObject var rateLimit: RateLimitCoordinator

    var body: some View {
        ZStack {
            if isLoading {
                content.hidden()
                ProgressView()
            } else {
                content
            }
        }
        .task {
            await refresh()
        }
        .environmentObject(rateLimit)
    }
}

extension LoadingView {
    func refresh() async {
        do {
            isLoading = true
            try await loader.refresh()
            print(rateLimit)
            isLoading = false
        } catch {
            print(error)
        }
    }
}
