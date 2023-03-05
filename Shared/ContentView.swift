//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HomeView(login: "DanielKrofchick")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
