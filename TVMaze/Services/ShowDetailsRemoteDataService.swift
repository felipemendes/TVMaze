//
//  ShowDetailsRemoteDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol ShowDetailsRemoteDataServiceProtocol {
    var showDetailsPublisher: Show? { get }
    var showDetailsSubscription: AnyCancellable? { get }
    var showDetailsURL: URL? { get }

    func fetchDetails()
}

class ShowDetailsRemoteDataService: ShowDetailsRemoteDataServiceProtocol {

    // MARK: - Initializer

    init(
        networkingManager: NetworkingManagerProtocol,
        showID: Int?,
        showDetailsURL: URL?
    ) {
        self.networkingManager = networkingManager
        self.showDetailsURL = Environment.showDetailsURL(showID: showID)
    }

    convenience init(
        networkingManager: NetworkingManagerProtocol,
        showID: Int?
    ) {
        let showDetailsURL = Environment.showDetailsURL(showID: showID)
        self.init(networkingManager: networkingManager, showID: showID, showDetailsURL: showDetailsURL)
    }

    // MARK: - Public API

    @Published var showDetailsPublisher: Show? = nil
    var showDetailsSubscription: AnyCancellable?
    let showDetailsURL: URL?
    var urlComponents: URLComponents?

    func fetchDetails() {
        showDetailsSubscription?.cancel()

        guard let showDetailsURL else { return }

        showDetailsSubscription = networkingManager.download(url: showDetailsURL)
            .decode(type: Show.self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] showDetails in
                guard let self else { return }
                self.showDetailsPublisher = showDetails
                self.showDetailsSubscription?.cancel()
            })
    }

    // MARK: - Private

    private let networkingManager: NetworkingManagerProtocol
}
