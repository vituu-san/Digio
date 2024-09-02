//
//  CarouselViewModelMock.swift
//  DigioTests
//
//  Created by Vitor Costa on 01/09/24.
//

import Foundation

@testable import Digio

final class CarouselViewModelMock: CarouselViewModeling {
    var view: CarouselViewing?
    var dataProvider: CarouselDataProviding
    var carousel: Carousel
    
    init(dataProvider: CarouselDataProviding, carousel: Carousel) {
        self.dataProvider = dataProvider
        self.carousel = carousel
    }

    private(set) var viewDidAppearCount = 0
    func viewDidAppear() {
        viewDidAppearCount += 1
    }
}
