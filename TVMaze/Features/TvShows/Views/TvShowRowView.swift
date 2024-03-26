//
//  TvShowRowView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct TvShowRowView: View {

    @EnvironmentObject var viewModelFactory: ViewModelFactory
    @State var tvShow: TvShow

    var body: some View {
        HStack {
            poster
            content
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.1),
                    radius: 10,
                    x: 0,
                    y: 0
                )
        )
        .frame(maxWidth: .infinity)
        .padding(8)
    }
}

// MARK: - Poster

extension TvShowRowView {
    @ViewBuilder private var poster: some View {
        if let image = tvShow.image {
            ImageView(viewModel: viewModelFactory.makeImageViewModel(tvShowImage: image, id: "\(tvShow.id)"))
                .scaledToFit()
                .padding()
                .frame(
                    width: UIScreen.main.bounds.width / 3,
                    height: 150)
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 2,
                    x: 2,
                    y: 2
                )
        }
    }
}

// MARK: - Content

extension TvShowRowView {
    @ViewBuilder private var content: some View {
        VStack(alignment: .leading) {
            Text(tvShow.name ?? "")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)

            if let genres = tvShow.genres {
                HStack {
                    ForEach(Array(genres.enumerated()), id: \.offset) { index, genre in
                        HStack {
                            Text(genre)
                                .font(.caption)
                                .foregroundStyle(Color.theme.secondaryText)
                                .lineLimit(1)

                            if index < genres.count - 1 {
                                Text("•")
                                    .font(.caption)
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }

            Divider()

            Text((tvShow.summary ?? "").strippingHTML)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .foregroundStyle(Color.theme.secondaryText)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TvShowRowView(tvShow: TvShow(
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
    ))
}
