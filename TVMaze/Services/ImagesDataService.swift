//
//  ImagesDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI
import Combine
import TVMazeServiceKit

protocol ImagesDataServiceProtocol {
    var image: UIImage? { get }
    var imageSubscription: AnyCancellable? { get }

    func fetchImage()
}

final class ImagesDataService: ImagesDataServiceProtocol {

    // MARK: - Initializer

    init(
        fileManager: LocalFileManagerProtocol = LocalFileManager(),
        networkingManager: NetworkingManagerProtocol = NetworkingManager(),
        imageName: String
    ) {
        self.fileManager = fileManager
        self.networkingManager = networkingManager
        self.imageName = imageName
    }

    // MARK: - Public API

    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?

    func fetchImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved local image")
        } else {
            downloadImage()
            print("Downloading remote image")
        }
    }

    // MARK: - Private

    private let fileManager: LocalFileManagerProtocol
    private let networkingManager: NetworkingManagerProtocol

    private let folderName = "coin_images"
    private let imageName: String

    private func downloadImage() {
        guard let url = URL(string: imageName) else { return }

        imageSubscription = networkingManager.download(url: url)
//            .tryMap { data -> UIImage? in
//                return UIImage(data: data)
//            }
            .tryMap { UIImage(data: $0) }
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] response in
                guard let self = self,
                      let downloadedImage = response else { return }

                self.image = downloadedImage
                self.imageSubscription?.cancel()

                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
