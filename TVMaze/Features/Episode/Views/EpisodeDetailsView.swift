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
    @ObservedObject var viewModel: EpisodeDetailsViewModel
    @Binding var episode: TvShow.Embedded.Episode?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                switch viewModel.state {
                case .loading:
                    loadingView
                case .content:
                    content
                case let .error(errorMessage):
                    Text(errorMessage)
                        .captionStyle()
                case let .empty(message):
                    Text(message)
                        .captionStyle()
                }
            }
            .padding()
            .navigationBarTitle("Episode Details")
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
                    
                    Text(episode.name ?? "")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Season \(episode.season ?? 0), Episode \(episode.number ?? 0)")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(Color.theme.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    episode.image.map {
                        ImageView(viewModel: viewModelFactory.makeImageViewModel(tvShowImage: $0, id: "\(episode.id)"))
                            .scaledToFit()
                            .shadow(
                                color: Color.black.opacity(0.3),
                                radius: 2,
                                x: 2,
                                y: 2
                            )
                    }

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
        EpisodeDetailsView(
            viewModel: ViewModelFactory().makeEpisodeDetailsViewModel(episode: nil), episode: .constant(episode))
    }
}
