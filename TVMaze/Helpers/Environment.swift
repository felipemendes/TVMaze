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
    static let tvShowsURLPath = "/shows"
}

// MARK: - TV Shows URL

extension Environment {
    static let tvShowsURL: URL? = {
        var components = URLComponents()
        components.scheme = Environment.scheme
        components.host = Environment.host
        components.path = Environment.tvShowsURLPath

        return components.url
    }()
}

// MARK: - TV Show Details URL

extension Environment {
    static func tvShowDetailsURL(tvShowID: Int?) -> URL? {
        guard let tvShowID else { return nil }

        var components = URLComponents()
        components.scheme = Environment.scheme
        components.host = Environment.host
        components.path = Environment.tvShowsURLPath + "/\(tvShowID)"
        components.queryItems = [
            URLQueryItem(name: "embed", value: "episodes")
        ]

        return components.url
    }
}
