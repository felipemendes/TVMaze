//
//  EpisodesBySeasonView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct EpisodesBySeasonView: View {
    @ObservedObject var viewModel: TvShowDetailsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    var body: some View {
        VStack(spacing: 20) {
            Text("Episodes by season")
                .font(.headline)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    ForEach(viewModel.episodesBySeason.keys.sorted(), id: \.self) { season in
                        SeasonView(season: season,
                                   episodes: viewModel.episodesBySeason[season] ?? [],
                                   viewModelFactory: viewModelFactory)
                    }
                }
            }
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    EpisodesBySeasonView(viewModel: ViewModelFactory().makeTvShowDetailsViewModel(
        tvShow: TvShow(
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
            embedded: TvShow.Embedded(
                episodes: [
                    TvShow.Embedded.Episode(
                        id: 1,
                        name: "Mock Episode 1",
                        season: 1,
                        number: 1,
                        image: TvShow.Image(
                            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                            original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
                        ))
                ])
        )))
    .environmentObject(ViewModelFactory())
}
