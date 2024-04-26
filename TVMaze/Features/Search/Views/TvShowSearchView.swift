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

    @State private var selectedTvShow: GlobalTvShow? = nil
    @State private var tvShowDetailView: Bool = false

    var body: some View {

        NavigationView {
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
                .background(
                    NavigationLink(
                        destination: TvShowDetailsView(viewModel: viewModelFactory.makeTvShowDetailsViewModel(tvShow: $selectedTvShow.wrappedValue?.show))
                            .environmentObject(viewModelFactory),
                        isActive: $tvShowDetailView) {
                            EmptyView()
                        }
                )
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - All TV Shows

extension TvShowSearchView {
    @ViewBuilder private var tvShowsContent: some View {
        List {
            ForEach(viewModel.allGlobalTvShows) { tvShow in
                Text(tvShow.show?.name ?? "Unknown TV Show")
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        segue(tvShow: tvShow)
                    }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.theme.background)
        }
    }
}

// MARK: - Segue

extension TvShowSearchView {
    private func segue(tvShow: GlobalTvShow) {
        selectedTvShow = tvShow
        tvShowDetailView.toggle()
    }
}

#Preview {
    NavigationView {
        TvShowSearchView(viewModel: ViewModelFactory().makeTvShowsSearchViewModel(searchTerm: "test"))
    }
    .environmentObject(ViewModelFactory())
}
