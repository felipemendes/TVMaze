//
//  ShowsRemoteDataServiceTests.swift
//  TVMazeTests
//
//  Created by Felipe Mendes on 25/03/24.
//

import XCTest
import Combine
@testable import TVMaze

final class ShowsRemoteDataServiceTests: XCTestCase {
    var mockNetworkingManager: MockNetworkingManager!
    var sut: ShowsRemoteDataService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkingManager = MockNetworkingManager()
        sut = ShowsRemoteDataService(
            networkingManager: mockNetworkingManager,
            showsURL: URL(string: "https://mock.shows.url")!)
        cancellables = []
    }

    override func tearDown() {
        mockNetworkingManager = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchShowsUsesCorrectURL() {
        // Given
        let expectedURL = URL(string: "https://mock.shows.url")!
        let sut = ShowsRemoteDataService(networkingManager: mockNetworkingManager, showsURL: expectedURL)

        // When
        sut.fetchShows()

        // Then
        XCTAssertEqual(mockNetworkingManager.lastUsedURL, expectedURL)
    }

    func test_fetchShowsSuccess() {
        // Given
        let mockShows = MockShow.shows
        let mockResponse = Just(mockShows)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        mockNetworkingManager.mockResponse = mockResponse

        let expectation = XCTestExpectation(description: "Fetch shows succeeds and publishes shows")

        // When
        sut.fetchShows()

        // Then
        sut.$showsPublisher
            .sink(receiveValue: { shows in
                XCTAssertEqual(shows.count, mockShows.count, "Fetched shows count should match mock shows count")
                XCTAssertEqual(shows.first?.name, mockShows.first?.name, "Fetched show name should match mock show name")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
