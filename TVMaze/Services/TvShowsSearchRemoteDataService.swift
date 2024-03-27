//
//  TvShowsSearchRemoteDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowsSearchRemoteDataServiceProtocol {
    var tvShowsPublisher: [GlobalTvShow] { get }
    var tvShowsSubscription: AnyCancellable? { get }
    var tvShowsURL: URL? { get }

    func fetchTvShows()
}

final class TvShowsSearchRemoteDataService: TvShowsSearchRemoteDataServiceProtocol {

    // MARK: - Initializer

    init(
        networkingManager: NetworkingManagerProtocol,
        tvShowsURL: URL?
    ) {
        self.networkingManager = networkingManager
        self.tvShowsURL = tvShowsURL
    }

    convenience init(
        networkingManager: NetworkingManagerProtocol,
        searchTerm: String
    ) {
        self.init(networkingManager: networkingManager, tvShowsURL: Constants.tvShowSearchURL(query: searchTerm))
    }

    // MARK: - Public API

    @Published var tvShowsPublisher: [GlobalTvShow] = []
    var tvShowsSubscription: AnyCancellable?
    var tvShowsURL: URL? {
        didSet {
            fetchTvShows()
        }
    }

    func updateSearchTerm(_ searchTerm: String) {
        tvShowsURL = Constants.tvShowSearchURL(query: searchTerm)
    }

    func fetchTvShows() {
        tvShowsSubscription?.cancel()
        guard let tvShowsURL else { return }

        tvShowsSubscription = networkingManager.download(url: tvShowsURL)
            .decode(type: [GlobalTvShow].self, decoder: JSONDecoder())
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
