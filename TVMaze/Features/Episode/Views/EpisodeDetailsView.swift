//
//  EpisodeDetailsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct EpisodeDetailsView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    @Binding var episode: TvShow.Embedded.Episode?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                content
            }
            .padding()
            .navigationBarTitle(episode?.name ?? "Episode Details")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
        }
    }
}

// MARK: - Content

extension EpisodeDetailsView {
    @ViewBuilder private var content: some View {
        if let episode = episode {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    episode.image.map {
                        ImageView(viewModel: viewModelFactory.makeImageViewModel(tvShowImage: $0, id: "\(episode.id)"))
                            .scaledToFit()
                    }

                    Text("Season \(episode.season ?? 0), Episode \(episode.number ?? 0)")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    SummaryView(summary: episode.summary)
                }
            }
        } else {
            Text("Episode details not available")
        }
    }
}

#Preview {
    NavigationView {
        let episode = TvShow.Embedded.Episode(
            id: 1,
            name: "Mock Episode 1",
            summary: "Mock Summary 2",
            season: 1,
            number: 1,
            image: TvShow.Image(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
            ))
        EpisodeDetailsView(episode: .constant(episode))
    }
}