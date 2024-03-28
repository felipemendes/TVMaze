//
//  XMarkButton.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct XMarkButton: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(
            action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
        )
    }
}

#Preview {
    XMarkButton()
}
