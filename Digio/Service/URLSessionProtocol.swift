//
//  URLSessionProtocol.swift
//  Digio
//
//  Created by Vitor Costa on 29/08/24.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URL,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
