//
//  ViewModelFactory.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation

class ViewModelFactory: ObservableObject {
    
    // MARK: - Shows

    func makeShowsViewModel() -> ShowsViewModel {
        let showsDataService = ShowsRemoteDataService()
        return ShowsViewModel(showDataService: showsDataService)
    }

    // MARK: - Details

    func makeDetailsViewModel(show: Show?) -> DetailsViewModel {
        let showDetailsDataService = ShowDetailsRemoteDataService(showID: show?.id)
        return DetailsViewModel(
            showDetailsDataService: showDetailsDataService,
            show: show)
    }
}
