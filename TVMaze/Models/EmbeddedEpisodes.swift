//
//  EmbeddedEpisodes.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation

extension TvShow {
    struct Embedded: Codable {
        let episodes: [Episode]?

        struct Episode: Codable, Identifiable {
            let id: Int
            let name: String?
            let season, number: Int?
            let image: TvShow.Image?
        }
    }
}
