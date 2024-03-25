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
        image: Image(
            medium: "https://www.testshow.com/image_medium.jpg",
            original: "https://www.testshow.com/image_original.jpg"
        ),
        summary: "Mock Summary 1"
    )

    static let show2 = Show(
        id: 2,
        name: "Mock Show 2",
        genres: ["Mock Genre 2"],
        schedule: Schedule(
            time: "21:00",
            days: ["Mock Day 2"]
        ),
        image: Image(
            medium: "https://www.testshow.com/image_medium.jpg",
            original: "https://www.testshow.com/image_original.jpg"
        ),
        summary: "Mock Summary 2"
    )
}
