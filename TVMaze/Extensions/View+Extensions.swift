//
//  View+Extensions.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

extension View {
    var loadingView: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: Color.theme.accent))
            .scaleEffect(2)
    }
}
