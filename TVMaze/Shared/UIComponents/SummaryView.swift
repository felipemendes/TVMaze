//
//  SummaryView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct SummaryView: View {
    
    var summary: String?

    var body: some View {
        VStack {
            Text("Summary")
                .foregroundStyle(Color.theme.accent)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            if let summary = summary {
                Text(summary.isEmpty ? "Unknown Summary" : summary.strippingHTML)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    SummaryView(summary: "Mock Summary")
}
