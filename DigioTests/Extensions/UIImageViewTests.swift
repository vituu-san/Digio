//
//  UIImageViewTests.swift
//  DigioTests
//
//  Created by Vitor Costa on 01/09/24.
//

import XCTest
import SnapshotTesting

@testable import Digio

final class UIImageViewTests: XCTestCase {
    private var sessionMock: URLSessionMock!
    private var sut: UIImageView!

    override func setUp() {
        sessionMock = URLSessionMock()
        sut = UIImageView(frame: .init(x: .zero, y: .zero, width: 100, height: 100))
    }

    override func tearDown() {
        sessionMock = nil
        sut = nil
    }
    
    func testSuccess_ShouldShowImageFromRequest() {
        let imageData = UIImage(named: "xbox")?.pngData()
        sessionMock.data = imageData
        sut.loadCachedImage(with: "https://www.google.com", session: sessionMock)
        
        wait(for: "Load image", during: 3)
        
        guard let image = sut.image else {
            XCTFail("Was not expect found nil.")
            return
        }

        assertSnapshot(of: image, as: .image)
    }

    func testFailure_WhenIsInvalidImage_ShouldShowBrokenImage() {
        sessionMock.data = jsonData
        sut.loadCachedImage(with: "https://www.google.com", session: sessionMock)

        wait(for: "Load image", during: 3)

        guard let image = sut.image else {
            XCTFail("Was not expect found nil.")
            return
        }

        assertSnapshot(of: image, as: .image)
    }

    func testFailure_WhenIsInvalidUrl_ShouldShowBrokenUrl() {
        sessionMock.data = jsonData
        sut.loadCachedImage(with: "", session: sessionMock)

        wait(for: "Load image", during: 3)

        guard let image = sut.image else {
            XCTFail("Was not expect found nil.")
            return
        }

        assertSnapshot(of: image, as: .image)
    }

    func testFailure_WhenIsNoData_ShouldShowNoData() {
        sut.loadCachedImage(with: "https://www.google.com", session: sessionMock)

        wait(for: "Load image", during: 3)

        guard let image = sut.image else {
            XCTFail("Was not expect found nil.")
            return
        }

        assertSnapshot(of: image, as: .image)
    }
}

extension XCTest {
    func wait(for message: String, during interval: TimeInterval) {
        let expectation = XCTestExpectation(description: message)
        XCTWaiter().wait(for: [expectation], timeout: interval)
    }
}
