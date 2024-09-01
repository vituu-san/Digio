//
//  SpotlightCarouselDataProvider.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import UIKit

protocol SpotlightCarouselDataProviding: UICollectionViewDataSource, UICollectionViewDelegate {
    var spotlights: [Spotlight] { get }
    var delegate: SpotlightCarouselDataProviderDelegate? { get set }
}

protocol SpotlightCarouselDataProviderDelegate: AnyObject {
    func didSelectItem(_ name: String)
}

final class SpotlightCarouselDataProvider: NSObject, SpotlightCarouselDataProviding {
    var spotlights: [Spotlight]
    
    weak var delegate: SpotlightCarouselDataProviderDelegate?
    
    init(spotlights: [Spotlight]) {
        self.spotlights = spotlights
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotlights.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCarouselCell",
                                                         for: indexPath) as? SpotlightCarouselCell {
            cell.updateImage(with: spotlights[indexPath.row].banner)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(spotlights[indexPath.row].name)
    }
}
