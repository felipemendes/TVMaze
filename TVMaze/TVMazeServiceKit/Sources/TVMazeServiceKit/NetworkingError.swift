//
//  NetworkingError.swift
//  
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

public enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown

    public var errorDescription: String? {
        switch self {
        case let .badURLResponse(url): return "Bad response from URL: \(url)"
        case .unknown: return "Unknown error occurred"
        }
    }
}
