//
//  SandboxService.swift
//  Digio
//
//  Created by Vitor Costa on 28/08/24.
//

import Foundation

enum SandboxError: Error {
    case invalidURL
    case hasError
    case noData
    case decodeError
}

protocol SandboxServicing {
    var session: URLSessionProtocol { get }
    func fetchSandbox(completionHandler: @escaping (Result<Sandbox, SandboxError>) -> Void)
}

final class SandboxService: SandboxServicing {
    var session: URLSessionProtocol

    private let baseUrlString = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox"

    private enum Endpoint: String {
        case products = "/products"
    }

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchSandbox(completionHandler: @escaping (Result<Sandbox, SandboxError>) -> Void) {
        guard let url = URL(string: baseUrlString + Endpoint.products.rawValue) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.hasError))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }

            do {
                let sandbox = try JSONDecoder().decode(Sandbox.self, from: data)
                completionHandler(.success(sandbox))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }

        task.resume()
    }
}
