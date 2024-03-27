//
//  TvShowsSearchViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import Foundation
import Combine
import TVMazeServiceKit

protocol TvShowsSearchViewModelProtocol {
    var allGlobalTvShows: [GlobalTvShow] { get }
    var state: ViewState { get }

    func reloadData()
}

final class TvShowsSearchViewModel: ObservableObject {

    // MARK: - Initializer

    init(tvShowDataService: TvShowsSearchRemoteDataService) {
        self.tvShowDataService = tvShowDataService

        addSubscribers()
    }

    // MARK: - Public API

    @Published var allGlobalTvShows: [GlobalTvShow] = []
    @Published var state: ViewState = .loading
    @Published var searchTerm: String = "" {
        didSet {
            reloadData()
        }
    }

    func reloadData() {
        guard !searchTerm.isEmpty else {
            state = .content
            return
        }

        tvShowDataService.updateSearchTerm(searchTerm)
    }

    // MARK: - Private

    private let tvShowDataService: TvShowsSearchRemoteDataService
    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        tvShowDataService.$tvShowsPublisher
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: self?.state = .content
                case let .failure(error): self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                self.allGlobalTvShows = response
                self.state = .content
            })
            .store(in: &cancellables)
    }
}
