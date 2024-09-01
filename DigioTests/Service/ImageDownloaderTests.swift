//
//  ImageDownloaderTests.swift
//  DigioTests
//
//  Created by Vitor Costa on 31/08/24.
//

import XCTest
import SnapshotTesting

@testable import Digio

final class ImageDownloaderTests: XCTestCase {
    private var sessionMock: URLSessionMock!
    private var sut: ImageDownloader!

    override func setUp() {
        sessionMock = URLSessionMock()
        sut = ImageDownloader(session: sessionMock)
    }

    override func tearDown() {
        sessionMock = nil
        sut = nil
    }

    func testDownload_WhenSuccess_ShouldReturnImage() {
        let expectedImage = UIImage(named: "broken-image")
        sessionMock.data = expectedImage?.pngData()

        sut.download(from: "https://www.google.com") { result in
            switch result {
            case .success(let image):
                assertSnapshot(of: image, as: .image)
            case .failure:
                XCTFail("Was not expect error.")
            }
        }
    }

    func testDownload_WhenFailureWithError_ShouldReturnNoDataError() {
        sessionMock.error = NSError()

        sut.download(from: "https://www.google.com") { result in
            switch result {
            case .success:
                XCTFail("Was not expect data.")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
        }
    }

    func testDownload_WhenURLIsInvalid_ShouldReturnInvalidURL() {
        sessionMock.error = NSError()

        sut.download(from: "") { result in
            switch result {
            case .success:
                XCTFail("Was not expect data.")
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            }
        }
    }

    func testDownload_WhenDataIsNotAnImage_ShouldReturnInvalidImage() {
        sessionMock.data = jsonData

        sut.download(from: "https://www.google.com") { result in
            switch result {
            case .success:
                XCTFail("Was not expect data.")
            case .failure(let error):
                XCTAssertEqual(error, .invalidImage)
            }
        }
    }
}
