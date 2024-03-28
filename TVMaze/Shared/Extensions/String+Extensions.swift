//
//  String+Extensions.swift
//  TVMaze
//
//  Created by Felipe Mendes on 27/03/24.
//

import Foundation

extension String {
    var strippingHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
