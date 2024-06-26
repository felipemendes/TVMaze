//
//  SeasonView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct SeasonView: View {
    let season: Int
    let episodes: [TvShow.Embedded.Episode]
    var viewModelFactory: ViewModelFactory

    @State private var episodeSelected: TvShow.Embedded.Episode? = nil
    @State private var episodeDetailView: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Season \(season)")
                .font(.subheadline)
                .bold()
                .foregroundStyle(Color.theme.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(episodes, id: \.id) { episode in
                        EpisodeView(episode: episode, viewModelFactory: viewModelFactory)
                            .onTapGesture {
                                segue(episode: episode)
                            }
                    }
                }
            }
            .sheet(item: $episodeSelected) { episode in
                EpisodeDetailsView(viewModel: viewModelFactory.makeEpisodeDetailsViewModel(episode: episode), episode: $episodeSelected)
            }
        }
    }
}

// MARK: - Segue

extension SeasonView {
    private func segue(episode: TvShow.Embedded.Episode) {
        episodeSelected = episode
        episodeDetailView.toggle()
    }
}
