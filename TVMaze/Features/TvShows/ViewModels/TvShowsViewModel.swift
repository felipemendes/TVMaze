//
//  TvShowsViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowsViewModelProtocol {
    var allTvShows: [TvShow] { get }
    var state: ViewState { get }

    func reloadData()
}

final class TvShowsViewModel: ObservableObject, TvShowsViewModelProtocol {

    // MARK: - Initializer

    init(tvShowDataService: TvShowsRemoteDataService) {
        self.tvShowDataService = tvShowDataService

        addSubscribers()
        reloadData()
    }

    // MARK: - Public API

    @Published var allTvShows: [TvShow] = []
    @Published var state: ViewState = .loading

    func reloadData() {
        tvShowDataService.fetchTvShows()
    }

    // MARK: - Private

    private let tvShowDataService: TvShowsRemoteDataService
    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDataService.$tvShowsPublisher
            .sink { [weak self] response in
                guard let self else {
                    self?.state = .error("Unknown Favorites")
                    return
                }

                self.allTvShows = response
                self.state = .content
            }
            .store(in: &cancellables)
    }
}
