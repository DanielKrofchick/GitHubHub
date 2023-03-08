//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

struct ContentView: View {
    @State var login: String

    var body: some View {
        NavigationStack {
            NavigationLink(value: login) {
                HomeView(model: .init(load: .init(login: login), avatar: nil))
            }
            .navigationDestination(for: String.self) {
                OrganizationsView(model: .init(load: .init(login: $0), items: nil))
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(login: defaultLogin)
    }
}
