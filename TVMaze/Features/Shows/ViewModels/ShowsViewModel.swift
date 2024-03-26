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
    var state: ViewState { get }

    func reloadData()
}

final class ShowsViewModel: ObservableObject {

    // MARK: - Initializer

    init(showDataService: ShowsRemoteDataService) {
        self.showDataService = showDataService
        addSubscribers()

        reloadData()
    }

    // MARK: - Public API

    @Published var allShows: [Show] = []
    @Published var state: ViewState = .loading

    func reloadData() {
        state = .loading
        showDataService.fetchShows()
    }

    // MARK: - Private

    private let showDataService: ShowsRemoteDataService
    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        showDataService.$showsPublisher
            .sink { [weak self] response in
                guard let self else { return }
                self.allShows = response
                self.state = .content
            }
            .store(in: &cancellables)
    }
}
