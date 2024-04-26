//
//  TvShowDetailsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct TvShowDetailsView: View {

    @ObservedObject var viewModel: TvShowDetailsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            switch viewModel.state {
            case .loading:
                loadingView
            case .content:
                ScrollView {
                    tvShowContent
                }
                .navigationTitle(viewModel.tvShow?.name ?? "Details")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        favoriteNavBarButton
                    }
                }
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

// MARK: - Search

extension TvShowDetailsView {
    private var favoriteNavBarButton: some View {
        Button(action: {
            if let tvShow = viewModel.tvShow {
                viewModel.updateFavorite(tvShow: tvShow)
            }
        }, label: {
            Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                .foregroundStyle(Color.yellow)
        })
        .font(.headline)
    }
}

// MARK: - Content

extension TvShowDetailsView {
    @ViewBuilder private var tvShowContent: some View {
        VStack(spacing: 20) {
            TvShowDetailsHeader(
                viewModel: viewModel,
                viewModelFactory: _viewModelFactory)
            SummaryView(summary: viewModel.tvShow?.summary)
            EpisodesBySeasonView(viewModel: viewModel)
                .environmentObject(viewModelFactory)
        }
        .padding()
    }
}

#Preview {
    NavigationView {
        let tvShow = TvShow(
            id: 1,
            name: "Mock TV Show 1",
            genres: ["Comedy", "Drama"],
            schedule: TvShow.Schedule(
                time: "20:00",
                days: ["Mock Day 1"]
            ),
            image: TvShow.Image(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
            ),
            summary: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar a ipsum vitae euismod. Aliquam sed venenatis lorem. Sed nec justo efficitur, molestie neque sed, consequat orci. Ut dictum quam vel bibendum bibendum. Mauris convallis, augue vitae faucibus molestie, urna ligula pretium nisi, ut semper arcu nisl ac enim. Integer posuere sollicitudin bibendum. Vestibulum eu lacinia ex. Nam ac augue pharetra, imperdiet nisl et, fermentum eros.</p>",
            embedded: nil
        )
        TvShowDetailsView(viewModel: ViewModelFactory().makeTvShowDetailsViewModel(tvShow: tvShow))
            .environmentObject(ViewModelFactory())
    }
}
