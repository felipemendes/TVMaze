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

    var body: some View {
        VStack(alignment: .leading) {
            Text("Season \(season)")
                .font(.subheadline)
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(episodes, id: \.id) { episode in
                        EpisodeView(episode: episode, viewModelFactory: viewModelFactory)
                    }
                }
            }
        }
    }
}
