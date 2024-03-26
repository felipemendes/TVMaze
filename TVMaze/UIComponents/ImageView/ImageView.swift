//
//  ImageView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

struct ImageView: View {

    @StateObject var viewModel: ImageViewModel

    init(imageName: String) {
        _viewModel = StateObject(wrappedValue: ImageViewModel(
            imagesDataService: ImagesDataService(imageName: imageName)))
    }

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
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ImageView(imageName: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg")
        .padding()
}
