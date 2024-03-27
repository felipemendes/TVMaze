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

    // MARK: - TV Shows

    func makeTvShowsViewModel() -> TvShowsViewModel {
        let tvShowsDataService = TvShowsRemoteDataService(networkingManager: networkingManager)
        return TvShowsViewModel(tvShowDataService: tvShowsDataService)
    }

    // MARK: - TV Shows

    func makeTvShowsSearchViewModel(searchTerm: String) -> TvShowsSearchViewModel {
        let tvShowsDataService = TvShowsSearchRemoteDataService(
            networkingManager: networkingManager,
            searchTerm: searchTerm)
        return TvShowsSearchViewModel(tvShowDataService: tvShowsDataService)
    }

    // MARK: - TV Show Details

    func makeTvShowDetailsViewModel(tvShow: TvShow?) -> TvShowDetailsViewModel {
        let tvShowDetailsDataService = TvShowDetailsRemoteDataService(
            networkingManager: networkingManager,
            tvShowID: tvShow?.id)
        return TvShowDetailsViewModel(
            tvShowDetailsDataService: tvShowDetailsDataService,
            tvShow: tvShow)
    }

    // MARK: - Image

    func makeImageViewModel(tvShowImage: TvShow.Image, id: String) -> ImageViewModel {
        let imagesDataService = ImagesDataService(
            fileManager: localFileManager,
            networkingManager: networkingManager,
            tvShowImage: tvShowImage,
            id: id)
        return ImageViewModel(imagesDataService: imagesDataService)
    }

    // MARK: - Episode Details

    func makeEpisodeDetailsViewModel(episode: TvShow.Embedded.Episode?) -> EpisodeDetailsViewModel {
        return EpisodeDetailsViewModel(episode: episode)
    }
}
