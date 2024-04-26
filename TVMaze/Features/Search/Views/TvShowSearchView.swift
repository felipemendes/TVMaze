//
//  TvShowSearchView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct TvShowSearchView: View {

    @ObservedObject var viewModel: TvShowsSearchViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    @Environment(\.dismiss) var dismiss

    var body: some View {

        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()

                VStack {
                    SearchBarView(searchTerm: $viewModel.searchTerm)

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

                    Spacer()
                }
                .navigationTitle("Search TV Shows")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        XMarkButton(dismiss: _dismiss)
                    }
                }
            }
        }
    }
}

// MARK: - All TV Shows

extension TvShowSearchView {
    @ViewBuilder private var tvShowsContent: some View {
        List {
            ForEach(viewModel.allGlobalTvShows) { tvShow in
                NavigationLink {
                    TvShowDetailsView(viewModel: viewModelFactory.makeTvShowDetailsViewModel(tvShow: tvShow.show))
                } label: {
                    Text(tvShow.show?.name ?? "Unknown TV Show")
                        .font(.subheadline)
                        .foregroundStyle(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .environmentObject(viewModelFactory)
                .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationView {
        TvShowSearchView(viewModel: ViewModelFactory().makeTvShowsSearchViewModel(searchTerm: "test"))
    }
    .environmentObject(ViewModelFactory())
}
