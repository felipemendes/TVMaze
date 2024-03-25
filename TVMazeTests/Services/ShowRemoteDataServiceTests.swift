//
//  ShowRemoteDataServiceTests.swift
//  TVMazeTests
//
//  Created by Felipe Mendes on 25/03/24.
//

import XCTest
import Combine
@testable import TVMaze

final class ShowRemoteDataServiceTests: XCTestCase {
    var mockNetworkingManager: MockNetworkingManager!
    var showRemoteDataService: ShowRemoteDataService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkingManager = MockNetworkingManager()
        showRemoteDataService = ShowRemoteDataService(networkingManager: mockNetworkingManager)
        cancellables = []
    }

    override func tearDown() {
        mockNetworkingManager = nil
        showRemoteDataService = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchShowsUsesCorrectURL() {
        // Given
        let expectedURL = URL(string: "https://mock.shows.url")!
        let service = ShowRemoteDataService(networkingManager: mockNetworkingManager, showsURL: expectedURL)

        // When
        service.fetchShows()

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
        showRemoteDataService.fetchShows()

        // Then
        showRemoteDataService.$showsPublisher
            .sink(receiveValue: { shows in
                XCTAssertEqual(shows.count, mockShows.count, "Fetched shows count should match mock shows count")
                XCTAssertEqual(shows.first?.name, mockShows.first?.name, "Fetched show name should match mock show name")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
