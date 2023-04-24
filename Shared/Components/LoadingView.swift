//
//  LoadingView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-04-21.
//

import SwiftUI

protocol Loadable {
    func load() async throws
}

struct LoadingView<Loader, Content>: View where Loader: Loadable, Content: View {
    let loader: Loadable
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
            await load()
        }
        .refreshable {
            await load()
        }
        .environmentObject(rateLimit)
    }
}

extension LoadingView {
    func load() async {
        do {
            isLoading = true
            try await loader.load()
            print(rateLimit)
            isLoading = false
        } catch {
            print(error)
        }
    }
}
