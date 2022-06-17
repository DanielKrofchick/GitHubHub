//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

struct ContentView: View {
    @State var user: UserView.Model = .init(name: "-")

    var body: some View {
        UserView(user: user)
            .padding()
            .onAppear {
                Task {
                    do {
                        let user = try await GitHub().user("DanielKrofchick")
                        if let fragment = user.data?.user?.fragments.userFragment {
                            self.user = UserView.Model(fragment)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
