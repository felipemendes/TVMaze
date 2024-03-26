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
        if let image = episode.image, 
            let episodeNumber = episode.number {
            ZStack(alignment: .bottomTrailing) {
                ImageView(viewModel: viewModelFactory.makeImageViewModel(tvShowImage: image, id: "\(episode.season ?? 0)_\(episode.id)"))
                    .scaledToFill()
                    .foregroundStyle(Color.theme.secondaryText)
                    .frame(
                        width: UIScreen.main.bounds.width / 3,
                        height: UIScreen.main.bounds.width / 3)
                    .shadow(
                        color: Color.black.opacity(0.3),
                        radius: 2, x: 2, y: 2)
                    .clipped()

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
    }
}
