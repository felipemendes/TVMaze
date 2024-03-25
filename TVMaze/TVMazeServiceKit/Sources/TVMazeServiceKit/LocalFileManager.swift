//
//  LocalFileManager.swift
//
//
//  Created by Felipe Mendes on 25/03/24.
//

import SwiftUI

public protocol LocalFileManagerProtocol {
    func saveImage(image: UIImage, imageName: String, folderName: String)
    func getImage(imageName: String, folderName: String) -> UIImage?
}

public final class LocalFileManager: LocalFileManagerProtocol {

    public init() { }

    public func saveImage(image: UIImage, imageName: String, folderName: String) {

        // Create folder
        createFolderIfNeeded(folderName: folderName)

        // Get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else {
            return
        }

        // Save image to path
        do {
            try data.write(to: url)
        } catch {
            print("Local File Manager Error Saving Image. FolderName: \(folderName): \(error)")
        }
    }

    public func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }

        return UIImage(contentsOfFile: url.path)
    }
}

// MARK: - Internal

extension LocalFileManager {
    internal func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }

        return url.appendingPathComponent(folderName)
    }
}

// MARK: - Private

extension LocalFileManager {
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Local File Manager Error creating directory. FolderName: \(folderName): \(error)")
            }
        }
    }

    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getURLForFolder(folderName: folderName) else {
            return nil
        }

        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}
