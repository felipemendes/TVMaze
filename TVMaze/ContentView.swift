//
//  ContentView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack {
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)

                Text("Secondary Text Color")
                    .foregroundStyle(Color.theme.secondaryText)
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
