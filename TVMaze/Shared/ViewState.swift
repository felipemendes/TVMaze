//
//  ViewState.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation

enum ViewState {
    case loading, content, empty(String), error(String)
}
