//
//  TvShowsFavoritesViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 27/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowsFavoritesViewModelProtocol {
    var allTvShows: [TvShow] { get }
    var state: ViewState { get }
}

final class TvShowsFavoritesViewModel: ObservableObject, TvShowsFavoritesViewModelProtocol {

    // MARK: - Initializer

    init(tvShowLocalDataService: TvShowLocalDataService) {
        self.tvShowLocalDataService = tvShowLocalDataService

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

    private let tvShowDataService = TvShowsRemoteDataService(networkingManager: NetworkingManager())
    private let tvShowLocalDataService: TvShowLocalDataService
    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDataService.$tvShowsPublisher
            .sink { [weak self] response in
                guard let self else { return }
                self.allTvShows = response
            }
            .store(in: &cancellables)

        $allTvShows
            .combineLatest(tvShowLocalDataService.$savedEntities)
            .map(mapFavorites)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: self?.state = .content
                case let .failure(error): self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self, let response else { return }
                self.allTvShows = response
            })
            .store(in: &cancellables)
    }

    private func mapFavorites(tvShows: [TvShow], tvShowEntity: [TvShowEntity]) -> [TvShow]? {
        var mappedTvShows = tvShows
            .compactMap { tvShow -> TvShow? in
                guard tvShowEntity.first(where: { $0.tvShowID == "\(tvShow.id)" }) != nil else {
                    return nil
                }

                return tvShow
            }
        sortFavorites(&mappedTvShows)
        return mappedTvShows
    }

    private func sortFavorites(_ tvShows: inout [TvShow]) {
        tvShows.sort { ($0.name ?? "") < ($1.name ?? "") }
    }
}
