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
        state = .loading
        tvShowDataService.fetchTvShows()
    }

    // MARK: - Private

    private let tvShowDataService: TvShowsRemoteDataService
    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDataService.$tvShowsPublisher
            .sink { [weak self] response in
                let state: ViewState = response.isEmpty ? .empty("No TV Shows to Display") : .content
                self?.state = state
                self?.allTvShows = response
            }
            .store(in: &cancellables)
    }
}
