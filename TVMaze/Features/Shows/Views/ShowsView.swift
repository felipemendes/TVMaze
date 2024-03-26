//
//  ShowsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct ShowsView: View {
    @ObservedObject var viewModel: ShowsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    @State private var selectedShow: Show? = nil
    @State private var showDetailView: Bool = false

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

extension ShowsView {
    private var tvShowsContent: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            List {
                ForEach(viewModel.allShows) { show in
                    ShowRowView(show: show)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture {
                            segue(show: show)
                        }
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
                destination: DetailsView(viewModel: viewModelFactory.makeDetailsViewModel(show: $selectedShow.wrappedValue))
                    .environmentObject(viewModelFactory),
                isActive: $showDetailView) {
                    EmptyView()
                }
        )
    }
}

extension ShowsView {
    private func segue(show: Show) {
        selectedShow = show
        showDetailView.toggle()
    }
}

#Preview {
    NavigationView {
        ShowsView(viewModel: ViewModelFactory().makeShowsViewModel())
    }
    .environmentObject(ViewModelFactory())
}
