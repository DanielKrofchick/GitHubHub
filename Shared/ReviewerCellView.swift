//
//  ReviewerCellView.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2023-03-19.
//

import SwiftUI
import OrderedCollections

extension ReviewerCellView {
    struct Model {
        let avatar: AvatarAgeView.Model
        let name: String?
        let backgroundColor: Color?
    }
}

struct ReviewerCellView: View {
    @State var model: Model

    var body: some View {
        HStack {
            AvatarAgeView(model: model.avatar, size: 40)
            Spacer(minLength: 15)
            if let name = model.name {
                Text(name)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(model.backgroundColor)
    }
}
