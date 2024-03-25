//
//  ShowsRemoteDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol ShowsRemoteDataServiceProtocol {
    var showsPublisher: [Show] { get }
    var showSubscription: AnyCancellable? { get }
    var showsURL: URL { get }

    func fetchShows()
}

final class ShowsRemoteDataService: ShowsRemoteDataServiceProtocol {

    // MARK: - Initializer

    init(
        networkingManager: NetworkingManagerProtocol,
        showsURL: URL
    ) {
        self.networkingManager = networkingManager
        self.showsURL = showsURL
    }

    convenience init?() {
        guard let url = Environment.showsURL else {
            return nil
        }

        self.init(networkingManager: NetworkingManager(), showsURL: url)
    }

    // MARK: - Public API

    @Published var showsPublisher: [Show] = []
    var showSubscription: AnyCancellable?
    let showsURL: URL

    func fetchShows() {
        showSubscription?.cancel()

        showSubscription = networkingManager.download(url: showsURL)
            .decode(type: [Show].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] shows in
                guard let self else { return }
                self.showsPublisher = shows
                self.showSubscription?.cancel()
            })
    }

    // MARK: - Private

    private let networkingManager: NetworkingManagerProtocol
}
