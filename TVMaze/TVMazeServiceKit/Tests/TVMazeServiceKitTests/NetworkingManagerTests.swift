//
//  NetworkingManagerTests.swift
//  
//
//  Created by Felipe Mendes on 25/03/24.
//

import XCTest
import Combine

@testable import TVMazeServiceKit

final class NetworkingManagerTests: XCTestCase {

    var sut: NetworkingManager!
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.ephemeral // avoiding caching
        configuration.protocolClasses = [MockURLProtocol.self]

        let session = URLSession(configuration: configuration)
        sut = NetworkingManager(session: session)
    }

    override func tearDown() {
        subscriptions = []
        super.tearDown()
    }

    func test_downloadSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Download succeeds")

        let mockData = "Mock data".data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, mockData)
        }

        // When
        sut.download(url: URL(string: "https://example.com")!)
            .sink(receiveCompletion: { _ in }, receiveValue: { data in

                // Then
                XCTAssertEqual(data, mockData, "The downloaded data does not match the mock data.")
                expectation.fulfill()
            })
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_downloadFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Download fails with bad URL response")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!, nil)
        }

        // When
        sut.download(url: URL(string: "https://example.com")!)
            .sink(receiveCompletion: { completion in

                // Then
                switch completion {
                case .failure(let error):
                    guard let networkingError = error as? TVMazeServiceKit.NetworkingError,
                          case .badURLResponse = networkingError else {
                        XCTFail("Expected badURLResponse error")
                        return
                    }
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1.0)
    }
}
