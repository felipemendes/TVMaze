//
//  DetailsViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol DetailsViewModelProtocol {
    var showDetailsDataService: ShowDetailsRemoteDataService { get }
    var show: Show? { get }
    var state: ViewState { get }

    func reloadData()
}

final class DetailsViewModel: ObservableObject, DetailsViewModelProtocol {

    // MARK: - Initializer

    init(
        showDetailsDataService: ShowDetailsRemoteDataService,
        show: Show?
    ) {
        self.showDetailsDataService = showDetailsDataService
        self.show = show

        addSubscribers()
    }

    // MARK: - Public API

    let showDetailsDataService: ShowDetailsRemoteDataService
    var show: Show?
    @Published var state: ViewState = .loading

    func reloadData() {
        state = .loading
        showDetailsDataService.fetchDetails()
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        showDetailsDataService.$showDetailsPublisher
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: self?.state = .content
                case let .failure(error): self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self,
                      let response else { return }
                self.show = response
                self.state = .content
            })
            .store(in: &cancellables)
    }
}
