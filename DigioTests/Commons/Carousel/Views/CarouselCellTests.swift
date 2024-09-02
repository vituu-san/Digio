//
//  SpotlightCarouselCellTests.swift
//  DigioTests
//
//  Created by Vitor Costa on 01/09/24.
//

import XCTest
import SnapshotTesting

@testable import Digio

final class CarouselCellTests: XCTestCase {
    private var sut: CarouselCell!
    private var sessionMock: URLSessionMock!

    override func setUp() {
        sessionMock = URLSessionMock()
        sut = CarouselCell(frame: CGRect(origin: .zero,
                                                  size: .init(width: 200, height: 80)))
    }

    override func tearDown() {
        sut = nil
        sessionMock = nil
    }

    func testInit_WhenLoadImage_ShouldHaveRightLayout() throws {
        let imageData = UIImage(named: "recharge-banner")?.pngData()
        sessionMock.data = imageData
        sut.updateImage(with: "https://www.google.com", session: sessionMock)
        
        wait(for: "Load image.", during: 3)
        
        assertSnapshot(of: sut, as: .image)
    }
}
