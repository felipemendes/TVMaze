//
//  TvShowsFavoritesView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 27/03/24.
//

import SwiftUI

struct TvShowsFavoritesView: View {
    @ObservedObject var viewModel: TvShowsFavoritesViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    @State private var selectedTvShow: TvShow? = nil
    @State private var tvShowDetailView: Bool = false
    @State private var isSearchSheetPresented = false

    var body: some View {

        switch viewModel.state {
        case .loading:
            loadingView
        case .content:
            tvShowsContent
        case let .error(errorMessage):
            Text(errorMessage)
                .captionStyle()
        case let .empty(message):
            Text(message)
                .captionStyle()
        }
    }
}

// MARK: - All TV Shows

extension TvShowsFavoritesView {
    private var tvShowsContent: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            List {
                ForEach(viewModel.allFavorites) { tvShow in
                    TvShowRowView(tvShow: tvShow, isFavorite: true)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture {
                            segue(tvShow: tvShow)
                        }
                        .environmentObject(viewModelFactory)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.reloadData()
            }
        }
        .navigationTitle("Favorites")
        .background(
            NavigationLink(
                destination: TvShowDetailsView(viewModel: viewModelFactory.makeTvShowDetailsViewModel(tvShow: $selectedTvShow.wrappedValue))
                    .environmentObject(viewModelFactory),
                isActive: $tvShowDetailView) {
                    EmptyView()
                }
        )
    }
}

// MARK: - Segue

extension TvShowsFavoritesView {
    private func segue(tvShow: TvShow) {
        selectedTvShow = tvShow
        tvShowDetailView.toggle()
    }
}

#Preview {
    NavigationView {
        TvShowsFavoritesView(viewModel: ViewModelFactory().makeTvShowsFavoritesViewModel())
    }
    .environmentObject(ViewModelFactory())
}
