//
//  TvShowDetailsViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowDetailsViewModelProtocol {
    var tvShowDetailsDataService: TvShowDetailsRemoteDataService { get }
    var tvShow: TvShow? { get }
    var state: ViewState { get }

    func reloadData()
}

final class TvShowDetailsViewModel: ObservableObject, TvShowDetailsViewModelProtocol {

    // MARK: - Initializer

    init(
        tvShowDetailsDataService: TvShowDetailsRemoteDataService,
        tvShow: TvShow?
    ) {
        self.tvShowDetailsDataService = tvShowDetailsDataService
        self.tvShow = tvShow

        addSubscribers()
    }

    // MARK: - Public API

    let tvShowDetailsDataService: TvShowDetailsRemoteDataService
    var tvShow: TvShow?
    @Published var state: ViewState = .loading

    func reloadData() {
        state = .loading
        tvShowDetailsDataService.fetchDetails()
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDetailsDataService.$tvShowDetailsPublisher
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: self?.state = .content
                case let .failure(error): self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self,
                      let response else { return }
                self.tvShow = response
                self.state = .content
            })
            .store(in: &cancellables)
    }
}
