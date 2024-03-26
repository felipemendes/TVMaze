//
//  TvShowsRemoteDataServiceTests.swift
//  TVMazeTests
//
//  Created by Felipe Mendes on 25/03/24.
//

import XCTest
import Combine
@testable import TVMaze

final class TvShowsRemoteDataServiceTests: XCTestCase {
    var mockNetworkingManager: MockNetworkingManager!
    var sut: TvShowsRemoteDataService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkingManager = MockNetworkingManager()
        sut = TvShowsRemoteDataService(
            networkingManager: mockNetworkingManager,
            tvShowsURL: URL(string: "https://mock.tvshows.url")!)
        cancellables = []
    }

    override func tearDown() {
        mockNetworkingManager = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchTvShowsUsesCorrectURL() {
        // Given
        let expectedURL = URL(string: "https://mock.shows.url")!
        let sut = TvShowsRemoteDataService(networkingManager: mockNetworkingManager, tvShowsURL: expectedURL)

        // When
        sut.fetchTvShows()

        // Then
        XCTAssertEqual(mockNetworkingManager.lastUsedURL, expectedURL)
    }

    func test_fetchTvShowsSuccess() {
        // Given
        let mockTvShows = MockTvShow.tvShows
        let mockResponse = Just(mockTvShows)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        mockNetworkingManager.mockResponse = mockResponse

        let expectation = XCTestExpectation(description: "Fetch tv shows succeeds and publishes tv shows")

        // When
        sut.fetchTvShows()

        // Then
        sut.$tvShowsPublisher
            .sink(receiveValue: { tvShows in
                XCTAssertEqual(tvShows.count, mockTvShows.count, "Fetched tv shows count should match mock tv shows count")
                XCTAssertEqual(tvShows.first?.name, mockTvShows.first?.name, "Fetched tv show name should match mock tv show name")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
