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
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ImageView(viewModel: ViewModelFactory().makeImageViewModel(
        show: Show(
            id: 1,
            name: "Mock Show 1",
            genres: ["Comedy", "Drama"],
            schedule: Schedule(
                time: "20:00",
                days: ["Mock Day 1"]
            ),
            image: ShowImage(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
            ),
            summary: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar a ipsum vitae euismod. Aliquam sed venenatis lorem. Sed nec justo efficitur, molestie neque sed, consequat orci. Ut dictum quam vel bibendum bibendum. Mauris convallis, augue vitae faucibus molestie, urna ligula pretium nisi, ut semper arcu nisl ac enim. Integer posuere sollicitudin bibendum. Vestibulum eu lacinia ex. Nam ac augue pharetra, imperdiet nisl et, fermentum eros.</p>",
            embedded: nil
        )))
    .padding()
}
