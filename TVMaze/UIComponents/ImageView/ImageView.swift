//
//  ImageView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct ImageView: View {

    @ObservedObject var viewModel: ImageViewModel

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
                    .frame(
                        width: UIScreen.main.bounds.width / 3,
                        height: UIScreen.main.bounds.width / 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(
                                Color.theme.accent.opacity(0.1),
                                lineWidth: 2)
                    )
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ImageView(viewModel: ViewModelFactory().makeImageViewModel(
        tvShowImage: TvShow.Image(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
        ),
        id: "1"))
    .padding()
}
