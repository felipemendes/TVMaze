//
//  NetworkingManager.swift
//  
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
import Combine

public protocol NetworkingManagerProtocol {
    func download(url: URL) -> AnyPublisher<Data, Error>
    func handleCompletion(completion: Subscribers.Completion<Error>)
}

public final class NetworkingManager: NetworkingManagerProtocol {

    // MARK: - Initializer

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - Public API

    public func download(url: URL) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try self.handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case let .failure(error): 
            print("Networking Manager Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Private

    private let session: URLSession

    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
}
