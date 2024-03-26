//
//  Schedule.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

extension TvShow {
    struct Schedule: Codable {
        let time: String?
        let days: [String]?
    }
}
