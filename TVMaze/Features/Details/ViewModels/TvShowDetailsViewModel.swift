//
//  TvShowDetailsViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowDetailsViewModelProtocol {
    var tvShowDetailsDataService: TvShowDetailsRemoteDataService { get }
    var tvShow: TvShow? { get }
    var state: ViewState { get }
    var episodesBySeason: [Int: [TvShow.Embedded.Episode]] { get }
    var isFavorite: Bool { get }

    func reloadData()
    func updateFavorite(tvShow: TvShow)
}

final class TvShowDetailsViewModel: ObservableObject, TvShowDetailsViewModelProtocol {

    // MARK: - Initializer

    init(
        tvShowDetailsDataService: TvShowDetailsRemoteDataService,
        tvShowLocalDataService: TvShowLocalDataService,
        tvShow: TvShow?
    ) {
        self.tvShowDetailsDataService = tvShowDetailsDataService
        self.tvShowLocalDataService = tvShowLocalDataService
        self.tvShow = tvShow

        addSubscribers()
        reloadData()
    }

    // MARK: - Public API

    let tvShowDetailsDataService: TvShowDetailsRemoteDataService
    let tvShowLocalDataService: TvShowLocalDataService
    var tvShow: TvShow?

    @Published var state: ViewState = .loading
    @Published var episodesBySeason: [Int: [TvShow.Embedded.Episode]] = [:]
    @Published var isFavorite: Bool = false

    func reloadData() {
        tvShowDetailsDataService.fetchDetails()
    }

    func updateFavorite(tvShow: TvShow) {
        tvShowLocalDataService.updateTvShow(tvShow)
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDetailsDataService.$tvShowDetailsPublisher
            .sink { [weak self] response in
                guard let self, let response else { return }
                self.groupEpisodesBySeason(tvShow: response)
            }
            .store(in: &cancellables)

        tvShowLocalDataService.$savedEntities
            .map(isFavorite)
            .sink { [weak self] response in
                self?.isFavorite = response
            }
            .store(in: &cancellables)
    }

    private func groupEpisodesBySeason(tvShow: TvShow) {
        self.tvShow = tvShow

        if let episodes = tvShow.embedded?.episodes {
            episodesBySeason = Dictionary(grouping: episodes) { $0.season ?? 0 }
        } else {
            episodesBySeason = [:]
        }

        state = .content
    }

    private func isFavorite(tvShowsEntity: [TvShowEntity]) -> Bool {
        guard let id = tvShow?.id else {
            return false
        }

        return tvShowsEntity.contains(where: { $0.tvShowID == "\(id)" })
    }
}
