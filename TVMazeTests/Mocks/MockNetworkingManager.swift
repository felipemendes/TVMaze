//
//  MockNetworkingManager.swift
//
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

@testable import TVMaze

final class MockNetworkingManager: NetworkingManagerProtocol {
    var mockResponse: AnyPublisher<[TvShow], Error>?
    var lastUsedURL: URL?

    func download(url: URL) -> AnyPublisher<Data, Error> {
        self.lastUsedURL = url

        return mockResponse?.map { data in
            try! JSONEncoder().encode(data)
        }
        .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }

    func handleCompletion(completion: Subscribers.Completion<Error>) { }
}
