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

    @StateObject private var appEnvironment = AppEnvironment()
    let viewModelFactory = ViewModelFactory()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]

        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]

        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)

        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some Scene {
        WindowGroup {
            AuthenticationView(viewModel: viewModelFactory.makeAuthenticationViewModel()) {
                TabView {
                    NavigationView {
                        TvShowsView(viewModel: viewModelFactory.makeTvShowsViewModel())
                    }
                    .tabItem {
                        Label("Shows", systemImage: "tv")
                    }

                    NavigationView {
                        TvShowsFavoritesView(viewModel: viewModelFactory.makeTvShowsFavoritesViewModel())
                    }
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }

                    NavigationView {
                        SettingsView(viewModel: viewModelFactory.makeSettingsViewModel())
                    }
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                }
                .environmentObject(viewModelFactory)
            }
            .environmentObject(appEnvironment)
        }
    }
}
