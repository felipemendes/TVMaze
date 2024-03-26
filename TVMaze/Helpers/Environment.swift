//
//  Environment.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

struct Environment {
    static let scheme = "https"
    static let host = "api.tvmaze.com"
    static let showsURLPath = "/shows"
}

// MARK: - TV Shows URL

extension Environment {
    static let showsURL: URL? = {
        var components = URLComponents()
        components.scheme = Environment.scheme
        components.host = Environment.host
        components.path = Environment.showsURLPath

        return components.url
    }()
}

// MARK: - TV Show Details URL

extension Environment {
    static func showDetailsURL(showID: Int?) -> URL? {
        guard let showID else { return nil }

        var components = URLComponents()
        components.scheme = Environment.scheme
        components.host = Environment.host
        components.path = Environment.showsURLPath + "/\(showID)"
        components.queryItems = [
            URLQueryItem(name: "embed", value: "episodes")
        ]

        return components.url
    }
}
