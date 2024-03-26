//
//  ViewModelFactory.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import TVMazeServiceKit

class ViewModelFactory: ObservableObject {
    
    // MARK: - Public API

    let networkingManager = NetworkingManager()
    let localFileManager = LocalFileManager()

    // MARK: - Shows

    func makeShowsViewModel() -> ShowsViewModel {
        let showsDataService = ShowsRemoteDataService(networkingManager: networkingManager)
        return ShowsViewModel(showDataService: showsDataService)
    }

    // MARK: - Details

    func makeDetailsViewModel(show: Show?) -> DetailsViewModel {
        let showDetailsDataService = ShowDetailsRemoteDataService(
            networkingManager: networkingManager,
            showID: show?.id)
        return DetailsViewModel(
            showDetailsDataService: showDetailsDataService,
            show: show)
    }

    // MARK: - Image

    func makeImageViewModel(show: Show) -> ImageViewModel {
        let imagesDataService = ImagesDataService(
            fileManager: localFileManager,
            networkingManager: networkingManager,
            show: show)
        return ImageViewModel(imagesDataService: imagesDataService)
    }
}
