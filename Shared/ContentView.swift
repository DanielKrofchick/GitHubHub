//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

struct ContentView: View {
    @State private var user: UserView?

    var body: some View {
        user
        Rectangle()
            .frame(width: 0, height: 0, alignment: .center)
            .onAppear {
                loadData()
            }
            .hidden()
    }

    private func loadData() {
        Task {
            do {
                let user = try await GitHub().user("DanielKrofchick")
                if let fragment = user.data?.user?.fragments.userFragment {
                    self.user = UserView(fragment)
                }
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
