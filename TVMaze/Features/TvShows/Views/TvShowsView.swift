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
                    ZStack {
                        TvShowRowView(tvShow: tvShow)

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
        }
        .navigationTitle("TV Shows")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                searchNavBarButton
            }
        }
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

#Preview {
    NavigationView {
        TvShowsView(viewModel: ViewModelFactory().makeTvShowsViewModel())
    }
    .environmentObject(ViewModelFactory())
}
