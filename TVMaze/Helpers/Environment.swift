//
//  Environment.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation

struct Environment {
    static let baseURLString = "https://api.tvmaze.com"
    static let showsURL = URL(string: "\(Environment.baseURLString)/shows")
}
