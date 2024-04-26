//
//  ShowDetailsRemoteDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowDetailsRemoteDataServiceProtocol {
    var tvShowDetailsPublisher: TvShow? { get }
    var tvShowDetailsSubscription: AnyCancellable? { get }
    var tvShowDetailsURL: URL? { get }

    func fetchDetails()
}

class TvShowDetailsRemoteDataService: TvShowDetailsRemoteDataServiceProtocol {

    // MARK: - Initializer

    init(
        networkingManager: NetworkingManagerProtocol,
        tvShowID: Int?,
        tvShowDetailsURL: URL?
    ) {
        self.networkingManager = networkingManager
        self.tvShowDetailsURL = Constants.tvShowDetailsURL(tvShowID: tvShowID)
    }

    convenience init(
        networkingManager: NetworkingManagerProtocol,
        tvShowID: Int?
    ) {
        let tvShowDetailsURL = Constants.tvShowDetailsURL(tvShowID: tvShowID)
        self.init(networkingManager: networkingManager, tvShowID: tvShowID, tvShowDetailsURL: tvShowDetailsURL)
    }

    // MARK: - Public API

    @Published var tvShowDetailsPublisher: TvShow? = nil
    var tvShowDetailsSubscription: AnyCancellable?
    let tvShowDetailsURL: URL?
    var urlComponents: URLComponents?

    func fetchDetails() {
        tvShowDetailsSubscription?.cancel()

        guard let tvShowDetailsURL else { return }

        tvShowDetailsSubscription = networkingManager.download(url: tvShowDetailsURL)
            .decode(type: TvShow.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] response in
                guard let self else { return }
                self.tvShowDetailsPublisher = response
                self.tvShowDetailsSubscription?.cancel()
            })
    }

    // MARK: - Private

    private let networkingManager: NetworkingManagerProtocol
}
