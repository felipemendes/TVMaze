//
//  LocalFileManagerTests.swift
//
//
//  Created by Felipe Mendes on 25/03/24.
//

import XCTest
import Combine

@testable import TVMazeServiceKit

final class LocalFileManagerTests: XCTestCase {

    var sut: LocalFileManager!
    let testFolderName = "LocalFileManagerTests"

    override func setUp() {
        super.setUp()
        sut = LocalFileManager()

        removeTestDirectory()
    }

    override func tearDown() {
        // Clean up after each test
        removeTestDirectory()
        super.tearDown()
    }

    func test_saveAndRetrieveImage() {
        // Given
        let imageName = "testImage"
        let image = UIImage(systemName: "house")!

        // When
        sut.saveImage(image: image, imageName: imageName, folderName: testFolderName)

        let retrievedImage = sut.getImage(imageName: imageName, folderName: testFolderName)

        // Then
        XCTAssertNotNil(retrievedImage, "Image should be retrieved successfully")
    }

    // MARK: - Helpers

    private func removeTestDirectory() {
        guard let url = sut.getURLForFolder(folderName: testFolderName) else {
            return
        }
        try? FileManager.default.removeItem(at: url)
    }
}
