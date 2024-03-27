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

    func reloadData()
}

final class TvShowDetailsViewModel: ObservableObject, TvShowDetailsViewModelProtocol {

    // MARK: - Initializer

    init(
        tvShowDetailsDataService: TvShowDetailsRemoteDataService,
        tvShow: TvShow?
    ) {
        self.tvShowDetailsDataService = tvShowDetailsDataService
        self.tvShow = tvShow
        addSubscribers()

        reloadData()
    }

    // MARK: - Public API

    let tvShowDetailsDataService: TvShowDetailsRemoteDataService
    var tvShow: TvShow?

    @Published var state: ViewState = .loading
    @Published var episodesBySeason: [Int: [TvShow.Embedded.Episode]] = [:]

    func reloadData() {
        state = .loading
        tvShowDetailsDataService.fetchDetails()
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDetailsDataService.$tvShowDetailsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: self?.state = .content
                case let .failure(error): self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self, let response else { return }
                self.groupEpisodesBySeason(tvShow: response)
            })
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
}
