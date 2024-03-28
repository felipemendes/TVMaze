//
//  EpisodeView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct EpisodeView: View {
    let episode: TvShow.Embedded.Episode
    var viewModelFactory: ViewModelFactory

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if let image = episode.image {
                ImageView(viewModel: viewModelFactory.makeImageViewModel(tvShowImage: image, id: "\(episode.season ?? 0)_\(episode.id)"))
                        .scaledToFill()
                        .frame(
                            width: UIScreen.main.bounds.width / 3,
                            height: UIScreen.main.bounds.width / 3)
                        .shadow(
                            color: Color.theme.accent.opacity(0.1),
                            radius: 10,
                            x: 0,
                            y: 0
                        )
                        .clipped()
                } else {
                    Image(systemName: "questionmark")
                        .foregroundStyle(Color.theme.secondaryText)
                        .frame(
                            width: UIScreen.main.bounds.width / 3,
                            height: UIScreen.main.bounds.width / 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(
                                    Color.theme.accent.opacity(0.1),
                                    lineWidth: 2)
                        )
                }

                if let episodeNumber = episode.number {
                    Text("\(episodeNumber)")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(Color.theme.accent)
                        .padding(6)
                        .background(
                            Circle()
                                .fill(Color.theme.background.opacity(0.75))
                        )
                        .offset(x: -10, y: -10)
                }
            }

            Text(episode.name ?? "Unknown Episode")
                .font(.subheadline)
                .lineLimit(2)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(width: UIScreen.main.bounds.width / 3)
        }
    }
}
