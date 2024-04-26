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
                        .listRowBackground(Color.theme.background)
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
                searchNavBarButton
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

// MARK: - Search

extension TvShowsView {
    private var searchNavBarButton: some View {
        Button(action: {
            isSearchSheetPresented.toggle()
        }, label: {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.accent)
        })
        .font(.headline)
        .sheet(isPresented: $isSearchSheetPresented) {
            TvShowSearchView(viewModel: viewModelFactory.makeTvShowsSearchViewModel(searchTerm: ""))
                .environmentObject(viewModelFactory)
        }
    }
}

// MARK: - Segue

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
