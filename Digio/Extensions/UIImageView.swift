//
//  UIImageView.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadCachedImage(with urlString: String, session: URLSessionProtocol = URLSession.shared) {
        self.contentMode = .scaleToFill
        self.tintColor = .lightGray

        self.image = nil

        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }

        let imageDownloader = ImageDownloader(session: session)

        imageDownloader.download(from: urlString) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let image):
                    imageCache.setObject(image, forKey: NSString(string: urlString))
                    self?.image = image
                case .failure(let error):
                    self?.contentMode = .scaleAspectFit
                    switch error {
                    case .invalidImage:
                        self?.image = UIImage(named: "broken-image")
                    case .invalidURL:
                        self?.image = UIImage(named: "broken-url")
                    case .noData:
                        self?.image = UIImage(named: "broken-data")
                    }
                }
            }
        }
    }
}
