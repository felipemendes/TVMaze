//
//  MockShow.swift
//  TVMazeTests
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
@testable import TVMaze

final class MockShow {
    
    private init() { }

    static let shows = [
        show1,
        show2
    ]

    static let show1 = Show(
        id: 1,
        name: "Mock Show 1",
        genres: ["Mock Genre 1"],
        schedule: Schedule(
            time: "20:00",
            days: ["Mock Day 1"]
        ),
        image: ShowImage(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
        ),
        summary: "Mock Summary 1",
        embedded: nil
    )

    static let show2 = Show(
        id: 2,
        name: "Mock Show 2",
        genres: ["Mock Genre 2"],
        schedule: Schedule(
            time: "21:00",
            days: ["Mock Day 2"]
        ),
        image: ShowImage(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/163/407679.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/163/407679.jpg"
        ),
        summary: "Mock Summary 2",
        embedded: nil
    )
}
