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
    var showsSubscription: AnyCancellable? { get }
    var showsURL: URL? { get }

    func fetchShows()
}

final class ShowsRemoteDataService: ShowsRemoteDataServiceProtocol {

    // MARK: - Initializer

    init(
        networkingManager: NetworkingManagerProtocol,
        showsURL: URL?
    ) {
        self.networkingManager = networkingManager
        self.showsURL = showsURL
    }

    convenience init(networkingManager: NetworkingManagerProtocol) {
        self.init(networkingManager: networkingManager, showsURL: Environment.showsURL)
    }

    // MARK: - Public API

    @Published var showsPublisher: [Show] = []
    var showsSubscription: AnyCancellable?
    let showsURL: URL?

    func fetchShows() {
        showsSubscription?.cancel()

        guard let showsURL else { return }

        showsSubscription = networkingManager.download(url: showsURL)
            .decode(type: [Show].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] shows in
                guard let self else { return }
                self.showsPublisher = shows
                self.showsSubscription?.cancel()
            })
    }

    // MARK: - Private

    private let networkingManager: NetworkingManagerProtocol
}
