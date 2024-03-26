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

    @StateObject private var showsViewModel: ShowsViewModel

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]

        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]

        let showDataService = ShowsRemoteDataService()
        _showsViewModel = StateObject(wrappedValue: ShowsViewModel(showDataService: showDataService))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ShowsView()
            }
        }
        .environmentObject(showsViewModel)
    }
}
