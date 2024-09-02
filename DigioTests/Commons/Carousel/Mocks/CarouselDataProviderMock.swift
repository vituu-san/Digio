//
//  CarouselDataProviderMock.swift
//  DigioTests
//
//  Created by Vitor Costa on 01/09/24.
//

import UIKit

@testable import Digio

final class CarouselDataProviderMock: NSObject, CarouselDataProviding {
    private(set) var reuseIdentifier: String = "CarouselDataProviderMock"
    private(set) var carousel: Carousel
    private(set) var session: URLSessionProtocol
    
    var delegate: CarouselDelegate?
    
    init(carousel: Carousel,
         session: URLSessionProtocol) {
        self.carousel = carousel
        self.session = session
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carousel.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return CarouselCell(frame: .zero)
    }
}
