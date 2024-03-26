//
//  ImageViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI
import Combine
import TVMazeServiceKit

protocol ImageViewModelProtocol {
    var image: UIImage? { get }
    var isLoading: Bool { get }
    var cancellables: Set<AnyCancellable> { get }
}

final class ImageViewModel: ObservableObject, ImageViewModelProtocol {

    // MARK: - Public API

    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init(imagesDataService: ImagesDataService) {
        self.imagesDataService = imagesDataService

        addSubscribers()

        self.isLoading = true
        self.imagesDataService.fetchImage()
    }

    // MARK: - Private

    private let imagesDataService: ImagesDataService

    private func addSubscribers() {
        imagesDataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] response in
                self?.image = response
            }
            .store(in: &cancellables)
    }
}
