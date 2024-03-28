//
//  TvShowsSearchViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowsSearchViewModelProtocol {
    var allGlobalTvShows: [GlobalTvShow] { get }
    var state: ViewState { get }

    func reloadData()
}

final class TvShowsSearchViewModel: ObservableObject {

    // MARK: - Initializer

    init(tvShowDataService: TvShowsSearchRemoteDataService) {
        self.tvShowDataService = tvShowDataService

        addSubscribers()
    }

    // MARK: - Public API

    @Published var allGlobalTvShows: [GlobalTvShow] = []
    @Published var state: ViewState = .loading
    @Published var searchTerm: String = "" {
        didSet {
            reloadData()
        }
    }

    func reloadData() {
        state = .loading
        tvShowDataService.updateSearchTerm(searchTerm)
    }

    // MARK: - Private

    private let tvShowDataService: TvShowsSearchRemoteDataService
    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDataService.$tvShowsPublisher
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self else {
                    self?.state = .error("Unknown Favorites")
                    return
                }

                let state: ViewState = response.isEmpty ? .empty("Use the search bar above to find TV shows. Just start typing, and we'll take care of the rest!") : .content
                self.state = state

                self.allGlobalTvShows = response
            }
            .store(in: &cancellables)
    }
}
