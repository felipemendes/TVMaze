//
//  Constants.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

struct Constants {
    static let scheme = "https"
    static let host = "api.tvmaze.com"
    static let tvShowsURLPath = "/shows"
    static let tvShowsSearchURLPath = "/search"
}

// MARK: - TV Shows URL

extension Constants {
    static let tvShowsURL: URL? = {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.tvShowsURLPath

        return components.url
    }()
}

// MARK: - TV Shows Search URL

extension Constants {
    static func tvShowSearchURL(query: String) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.tvShowsSearchURLPath + Constants.tvShowsURLPath
        components.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]

        return components.url
    }
}

// MARK: - TV Show Details URL

extension Constants {
    static func tvShowDetailsURL(tvShowID: Int?) -> URL? {
        guard let tvShowID else { return nil }

        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.tvShowsURLPath + "/\(tvShowID)"
        components.queryItems = [
            URLQueryItem(name: "embed", value: "episodes")
        ]

        return components.url
    }
}
