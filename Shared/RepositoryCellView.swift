//
//  RepositoryCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-11.
//

import SwiftUI

struct RepositoryCellView: View {
    struct Model {
        let title: String
        let count: String?
    }

    @State var model: Model

    var body: some View {
        HStack {
            Text(model.title).frame(maxWidth: .infinity, alignment: .leading)
            if let count = model.count {
                Text(count).frame(alignment: .trailing)
            }
        }
    }
}

extension RepositoryCellView.Model {
    init(_ fragment: RepositoryFragment) {
        self.init(
            title: fragment.name,
            count: String(fragment.pullRequests.totalCount)
        )
    }
}
