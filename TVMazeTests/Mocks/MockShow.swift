//
//  MockTvShow.swift
//  TVMazeTests
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
@testable import TVMaze

final class MockTvShow {

    private init() { }

    static let tvShows = [
        tvShow1,
        tvShow2
    ]

    static let tvShow1 = TvShow(
        id: 1,
        name: "Mock TV Show 1",
        genres: ["Mock Genre 1"],
        schedule: TvShow.Schedule(
            time: "20:00",
            days: ["Mock Day 1"]
        ),
        image: TvShow.Image(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
        ),
        summary: "Mock Summary 1",
        embedded: nil
    )

    static let tvShow2 = TvShow(
        id: 2,
        name: "Mock TV Show 2",
        genres: ["Mock Genre 2"],
        schedule: TvShow.Schedule(
            time: "21:00",
            days: ["Mock Day 2"]
        ),
        image: TvShow.Image(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/163/407679.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/163/407679.jpg"
        ),
        summary: "Mock Summary 2",
        embedded: nil
    )
}
