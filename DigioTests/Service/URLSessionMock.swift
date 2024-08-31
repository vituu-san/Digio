//
//  URLSessionMock.swift
//  DigioTests
//
//  Created by Vitor Costa on 29/08/24.
//

import Foundation

@testable import Digio

final class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func dataTask(with request: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskMock { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        }
        return task
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
