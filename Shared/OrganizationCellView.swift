//
//  OrganizationCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-11.
//

import SwiftUI

extension OrganizationCellView {
    struct Model {
        let avatar: AvatarView.Model
        let title: String
        let count: String?
    }
}

struct OrganizationCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            AvatarView(model: model.avatar)
            Text(model.title).frame(maxWidth: .infinity, alignment: .leading)
            if let count = model.count {
                Text(count).frame(alignment: .trailing)
            }
        }
    }
}

extension OrganizationCellView.Model {
    init(_ fragment: OrganizationFragment) {
        self.init(
            avatar: .init(fragment, name: nil),
            title: fragment.login,
            count: String(fragment.repositories.totalCount)
        )
    }
}
