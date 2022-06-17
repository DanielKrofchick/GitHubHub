//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                GitHub().userGraphQL("DanielKrofchick")
                GitHub().repos(
                    user: "DanielKrofchick",
                    repo: "toronto311"
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
