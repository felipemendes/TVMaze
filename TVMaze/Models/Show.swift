//
//  Show.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

struct Show: Identifiable, Codable {
    let id: Int?
    let name: String?
    let genres: [String]?
    let schedule: Schedule?
    let image: ShowImage?
    let summary: String?
}
