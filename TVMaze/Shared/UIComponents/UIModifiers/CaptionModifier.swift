//
//  CaptionModifier.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import SwiftUI

struct CaptionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(Color.theme.secondaryText)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func captionStyle() -> some View {
        self.modifier(CaptionModifier())
    }
}
