//
//  SpotlightCarouselDataProvider.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import UIKit

protocol CarouselDataProviding: UICollectionViewDataSource, UICollectionViewDelegate {
    var reuseIdentifier: String { get }
    var carousel: Carousel { get }
    var session: URLSessionProtocol { get }
    var delegate: CarouselDelegate? { get set }
}

protocol CarouselDelegate: AnyObject {
    func didSelectItem(_ name: String)
}

final class CarouselDataProvider: NSObject, CarouselDataProviding {
    var reuseIdentifier: String
    var carousel: Carousel
    var session: URLSessionProtocol
    
    weak var delegate: CarouselDelegate?
    
    init(reuseIdentifier: String, 
         carousel: Carousel,
         session: URLSessionProtocol = URLSession.shared) {
        self.reuseIdentifier = reuseIdentifier
        self.carousel = carousel
        self.session = session
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carousel.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? CarouselCell {
            cell.updateImage(with: carousel.items[indexPath.row].urlString,
                             session: session)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(carousel.items[indexPath.row].id)
    }
}
