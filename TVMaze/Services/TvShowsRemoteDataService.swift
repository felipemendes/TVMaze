//
//  TvShowsRemoteDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowsRemoteDataServiceProtocol {
    var tvShowsPublisher: [TvShow] { get }
    var tvShowsSubscription: AnyCancellable? { get }
    var tvShowsURL: URL? { get }

    func fetchTvShows()
}

final class TvShowsRemoteDataService: TvShowsRemoteDataServiceProtocol {

    // MARK: - Initializer

    init(
        networkingManager: NetworkingManagerProtocol,
        tvShowsURL: URL?
    ) {
        self.networkingManager = networkingManager
        self.tvShowsURL = tvShowsURL
    }

    convenience init(networkingManager: NetworkingManagerProtocol) {
        self.init(networkingManager: networkingManager, tvShowsURL: Constants.tvShowsURL)
    }

    // MARK: - Public API

    @Published var tvShowsPublisher: [TvShow] = []
    var tvShowsSubscription: AnyCancellable?
    let tvShowsURL: URL?

    func fetchTvShows() {
        tvShowsSubscription?.cancel()

        guard let tvShowsURL else { return }

        tvShowsSubscription = networkingManager.download(url: tvShowsURL)
            .decode(type: [TvShow].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] tvShows in
                guard let self else { return }
                self.tvShowsPublisher = tvShows
                self.tvShowsSubscription?.cancel()
            })
    }

    // MARK: - Private

    private let networkingManager: NetworkingManagerProtocol
}
