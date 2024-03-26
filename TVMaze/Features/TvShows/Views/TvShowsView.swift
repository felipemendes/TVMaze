//
//  TvShowsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct TvShowsView: View {
    @ObservedObject var viewModel: TvShowsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    @State private var selectedTvShow: TvShow? = nil
    @State private var tvShowDetailView: Bool = false

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

// MARK: - All TV Shows

extension TvShowsView {
    private var tvShowsContent: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            List {
                ForEach(viewModel.allTvShows) { tvShow in
                    TvShowRowView(tvShow: tvShow)
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
        .navigationTitle("TV Shows")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.theme.accent)
            }
        }
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

extension TvShowsView {
    private func segue(tvShow: TvShow) {
        selectedTvShow = tvShow
        tvShowDetailView.toggle()
    }
}

#Preview {
    NavigationView {
        TvShowsView(viewModel: ViewModelFactory().makeTvShowsViewModel())
    }
    .environmentObject(ViewModelFactory())
}
