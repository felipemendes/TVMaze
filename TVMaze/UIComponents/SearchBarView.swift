//
//  SearchBarView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct SearchBarView: View {

    @Binding var searchTerm: String
    @FocusState private var isSearchFieldFocused: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchTerm.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )

            TextField("Search series by name...", text: $searchTerm)
                .foregroundStyle(Color.theme.accent)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled()
                .focused($isSearchFieldFocused)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 15)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchTerm.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            isSearchFieldFocused = true
                            searchTerm = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.2),
                    radius: 8,
                    x: 0,
                    y: 0
                )
        )
        .padding()
        .onAppear {
            DispatchQueue.main.async {
                self.isSearchFieldFocused = true
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchTerm: .constant(""))
}
