//
//  RepositoryCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-11.
//

import SwiftUI

extension RepositoryCellView {
    struct Model {
        let title: String
        let count: String?
        let lastUpdate: AttributedString?
    }
}

struct RepositoryCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            Text(model.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let lastUpdate = model.lastUpdate {
                Text(lastUpdate)
                    .frame(alignment: .trailing)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            if let count = model.count {
                Text(count)
                    .frame(alignment: .trailing)
            }
        }
    }
}

extension RepositoryCellView.Model {
    init(_ fragment: RepositoryFragment) {
        self.init(
            title: fragment.name,
            count: String(fragment.pullRequests.totalCount),
            lastUpdate: fragment.pushedAt?.date?.relativeAttributed()
        )
    }
}
