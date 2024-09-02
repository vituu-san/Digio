//
//  SpotlightCarouselViewModel.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import Foundation

protocol CarouselViewModeling: AnyObject {
    var view: CarouselViewing? { get set }
    var dataProvider: CarouselDataProviding { get }
    var carousel: Carousel { get }
    func viewDidAppear()
}

final class CarouselViewModel: NSObject, CarouselViewModeling {
    weak var view: CarouselViewing?
    
    var carousel: Carousel
    var dataProvider: CarouselDataProviding

    init(carousel: Carousel, dataProvider: CarouselDataProviding) {
        self.carousel = carousel
        self.dataProvider = dataProvider
        super.init()
        dataProvider.delegate = self
    }
    
    func viewDidAppear() {
        view?.reloadCollection()
    }
}

extension CarouselViewModel: CarouselDelegate {
    var session: URLSessionProtocol { URLSession.shared }

    func didSelectItem(_ name: String) {
        // TODO: Link to DetailsView
    }
}
