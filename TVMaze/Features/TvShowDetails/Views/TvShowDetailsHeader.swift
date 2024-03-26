//
//  TvShowDetailsHeader.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct TvShowDetailsHeader: View {

    @ObservedObject var viewModel: TvShowDetailsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    var body: some View {
        HStack {
            poster
            VStack(alignment: .leading, spacing: 10) {
                genres
                Divider()
                schedule
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .font(.subheadline)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Poster

extension TvShowDetailsHeader {
    @ViewBuilder private var poster: some View {
        if let tvShow = viewModel.tvShow {
            ImageView(viewModel: viewModelFactory.makeImageViewModel(tvShow: tvShow))
                .scaledToFit()
                .foregroundStyle(Color.theme.secondaryText)
                .padding()
                .frame(
                    width: UIScreen.main.bounds.width / 2,
                    height: 300)
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 2,
                    x: 2,
                    y: 2
                )
        }
    }
}

// MARK: - Genres

extension TvShowDetailsHeader {
    @ViewBuilder private var genres: some View {
        if let genres = viewModel.tvShow?.genres {
            VStack(alignment: .listRowSeparatorLeading) {
                Text("Genres")
                    .foregroundStyle(Color.theme.accent)
                ForEach(Array(genres.enumerated()), id: \.offset) { index, genre in
                    Text(genre)
                        .bold()
                        .foregroundStyle(Color.theme.secondaryText)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Schedule

extension TvShowDetailsHeader {
    @ViewBuilder private var schedule: some View {
        if let schedule = viewModel.tvShow?.schedule,
           let days = schedule.days,
           let time = schedule.time {

            HStack(alignment: .top) {
                VStack(alignment: .listRowSeparatorLeading) {
                    Text("On air")
                        .font(.subheadline)
                        .foregroundStyle(Color.theme.accent)
                    ForEach(Array(days.enumerated()), id: \.offset) { index, genre in
                        Text(genre)
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(Color.theme.secondaryText)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .listRowSeparatorLeading) {
                    Text("At")
                        .font(.subheadline)
                        .foregroundStyle(Color.theme.accent)
                    Text(time)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(Color.theme.secondaryText)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TvShowDetailsHeader(viewModel: ViewModelFactory().makeTvShowDetailsViewModel(
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
            embedded: nil
        )))
    .environmentObject(ViewModelFactory())
}
