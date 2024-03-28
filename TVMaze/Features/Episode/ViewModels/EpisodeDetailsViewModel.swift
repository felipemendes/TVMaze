//
//  EpisodeViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine

protocol EpisodeDetailsViewModelProtocol: ObservableObject {
    var episode: TvShow.Embedded.Episode? { get }
    var state: ViewState { get }
}

final class EpisodeDetailsViewModel: ObservableObject, EpisodeDetailsViewModelProtocol {

    // MARK: - Public API

    @Published var episode: TvShow.Embedded.Episode?
    @Published var state: ViewState = .loading

    // MARK: - Initializer

    init(episode: TvShow.Embedded.Episode?) {
        self.episode = episode
        self.state = .content
    }
}
