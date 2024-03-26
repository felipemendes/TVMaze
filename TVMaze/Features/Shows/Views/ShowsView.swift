//
//  ShowsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct ShowsView: View {
    @EnvironmentObject private var viewModel: ShowsViewModel

    var body: some View {

        switch viewModel.state {
        case .loading:
            loadingView
        case .content:
            tvShowsContent
        case let .error(errorMessage):
            Text(errorMessage)
        }
    }
}

// MARK: - Loading

extension ShowsView {
    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: Color.theme.accent))
            .scaleEffect(2)
    }
}

// MARK: - All TV Shows

extension ShowsView {
    private var tvShowsContent: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            List {
                ForEach(viewModel.allShows) { show in
                    ShowRowView(show: show)
                        .listRowInsets(EdgeInsets())
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .navigationTitle("TV Shows")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.theme.accent)
            }
        }
    }
}

#Preview {
    NavigationView {
        ShowsView()
    }
    .environmentObject(ShowsViewModel(showDataService: ShowsRemoteDataService()))
}
