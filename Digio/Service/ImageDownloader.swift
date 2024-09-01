//
//  ImageDownloader.swift
//  Digio
//
//  Created by Vitor Costa on 31/08/24.
//

import UIKit

protocol ImageDownloading {
    var session: URLSessionProtocol { get }
    func download(from urlString: String,
                  completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void)
}

enum ImageDownloadError: Error {
    case invalidURL
    case noData
    case invalidImage
}

final class ImageDownloader: ImageDownloading {
    var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func download(from urlString: String,
                  completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.noData))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.invalidImage))
            }
        }

        task.resume()
    }
}
