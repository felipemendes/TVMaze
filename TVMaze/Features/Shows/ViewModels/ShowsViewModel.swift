//
//  ShowsViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol ShowsViewModelProtocol {
    var allShows: [Show] { get }
}

final class ShowsViewModel: ObservableObject {

    @Published var allShows: [Show] = []

    private let showDataService: ShowsRemoteDataService
    private var cancellables = Set<AnyCancellable>()

    init(showDataService: ShowsRemoteDataService) {
        self.showDataService = showDataService

        addSubscribers()
        showDataService.fetchShows()
    }

    private func addSubscribers() {
        showDataService.$showsPublisher
            .sink { response in
                self.allShows = response
            }
            .store(in: &cancellables)
    }
}
