//
//  SandboxServiceTests.swift
//  DigioTests
//
//  Created by Vitor Costa on 29/08/24.
//

import XCTest

@testable import Digio

final class SandboxServiceTests: XCTestCase {
    private var sessionMock: URLSessionMock!
    private var sut: SandboxService!

    override func setUp() {
        sessionMock = URLSessionMock()
        sut = SandboxService(session: sessionMock)
    }

    override func tearDown() {
        sessionMock = nil
        sut = nil
    }

    func testSuccess_WithData_ShouldReturnSandbox() {
        sessionMock.data = jsonData

        let expectation = XCTestExpectation(description: "Fetch sandbox")

        sut.fetchSandbox { result in
            switch result {
            case .success(let sandbox):
                XCTAssertEqual(sandbox.spotlight.count, 2)
                XCTAssertEqual(sandbox.products.count, 3)
            case .failure:
                XCTFail("Was not expect error.")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSuccess_WithoutData_ShouldReturnNoDataError() {
        let expectation = XCTestExpectation(description: "Fetch sandbox")

        sut.fetchSandbox { result in
            switch result {
            case .success:
                XCTFail("Was not expect data.")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testFailure_WithError_ShouldReturnError() {
        sessionMock.error = SandboxError.hasError

        let expectation = XCTestExpectation(description: "Fetch sandbox")

        sut.fetchSandbox { result in
            switch result {
            case .success:
                XCTFail("Was not expect data.")
            case .failure(let error):
                XCTAssertEqual(error, .hasError)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // swiftlint:disable non_optional_string_data_conversion
    func testFailure_WithDecodeError_ShouldReturnDecodeError() {
        let jsonWrongData = """
        { }
        """.data(using: .utf8)!

        sessionMock.data = jsonWrongData

        let expectation = XCTestExpectation(description: "Fetch sandbox")

        sut.fetchSandbox { result in
            switch result {
            case .success:
                XCTFail("Was not expect data.")
            case .failure(let error):
                XCTAssertEqual(error, .decodeError)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
