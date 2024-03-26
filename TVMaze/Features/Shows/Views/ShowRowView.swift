//
//  ShowRowView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct ShowRowView: View {

    let show: Show

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

extension ShowRowView {
    @ViewBuilder private var poster: some View {
        if let image = show.image?.medium {
            ImageView(imageName: image)
                .scaledToFit()
                .foregroundStyle(Color.theme.secondaryText)
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
        } else {
            Image(systemName: "questionmark")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.theme.secondaryText)
                .padding()
                .frame(
                    width: UIScreen.main.bounds.width / 3,
                    height: 100)
        }
    }
}

// MARK: - Content

extension ShowRowView {
    @ViewBuilder private var content: some View {
        VStack(alignment: .leading) {
            Text(show.name ?? "")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)

            if let genres = show.genres {
                HStack {
                    ForEach(Array(genres.enumerated()), id: \.offset) { _, genre in
                        Text(genre)
                            .font(.caption)
                            .foregroundStyle(Color.theme.secondaryText)
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }

            Divider()

            Text((show.summary ?? "").strippingHTML)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundStyle(Color.theme.secondaryText)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ShowRowView(show: Show(
        id: 1,
        name: "Mock Show 1",
        genres: ["Comedy", "Drama", "Mock 1", "Mock 2"],
        schedule: Schedule(
            time: "20:00",
            days: ["Mock Day 1"]
        ),
        image: ShowImage(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
        ),
        summary: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar a ipsum vitae euismod. Aliquam sed venenatis lorem. Sed nec justo efficitur, molestie neque sed, consequat orci. Ut dictum quam vel bibendum bibendum. Mauris convallis, augue vitae faucibus molestie, urna ligula pretium nisi, ut semper arcu nisl ac enim. Integer posuere sollicitudin bibendum. Vestibulum eu lacinia ex. Nam ac augue pharetra, imperdiet nisl et, fermentum eros.</p>"
    ))
}
