//
//  Show.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

// TVmaze API
/*

 TV Shows URL: https://api.tvmaze.com/shows
 Episodes URL: https://api.tvmaze.com/shows/1?embed=episodes

 */

struct Show: Identifiable, Codable {
    let id: Int
    let name: String?
    let genres: [String]?
    let schedule: Schedule?
    let image: ShowImage?
    let summary: String?
    let embedded: Embedded?
}

extension Show {
    enum CodingKeys: String, CodingKey {
        case id, name, genres, schedule, image, summary
        case embedded = "_embedded"
    }
}
