//
//  DetailsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

struct DetailsView: View {

    @ObservedObject var viewModel: DetailsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                loadingView
            case .content:
                tvShowContent
            case let .error(errorMessage):
                Text(errorMessage)
            }
        }
        .onAppear {
            viewModel.reloadData()
        }
    }
}

extension DetailsView {
    private var tvShowContent: some View {
        VStack {
            Text(viewModel.show?.name ?? "")
            Text(viewModel.show?.embedded?.episodes?.description ?? "")
        }
    }
}

#Preview {
    NavigationView {
        let show = Show(
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
        )
        DetailsView(viewModel: ViewModelFactory().makeDetailsViewModel(show: show))
            .environmentObject(ViewModelFactory())
    }
}
