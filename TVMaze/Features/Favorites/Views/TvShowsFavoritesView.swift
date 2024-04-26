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

        ZStack {
            Color.theme.background
                .ignoresSafeArea()

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
}

// MARK: - All TV Shows

extension TvShowsFavoritesView {
    private var tvShowsContent: some View {
        List {
            ForEach(viewModel.allFavorites) { tvShow in
                ZStack {
                    TvShowRowView(tvShow: tvShow, isFavorite: true)

                    NavigationLink {
                        TvShowDetailsView(viewModel: viewModelFactory.makeTvShowDetailsViewModel(tvShow: tvShow))
                    } label: {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .environmentObject(viewModelFactory)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.reloadData()
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    NavigationView {
        TvShowsFavoritesView(viewModel: ViewModelFactory().makeTvShowsFavoritesViewModel())
    }
    .environmentObject(ViewModelFactory())
}
