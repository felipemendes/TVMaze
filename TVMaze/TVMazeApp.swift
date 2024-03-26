//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI
import TVMazeServiceKit

@main
struct TVMazeApp: App {

    let viewModelFactory = ViewModelFactory()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]

        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ShowsView(viewModel: viewModelFactory.makeShowsViewModel())
            }
        }
        .environmentObject(viewModelFactory)
    }
}
