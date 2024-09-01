//
//  SpotlightCarouselViewModel.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import Foundation

protocol SpotlightCarouselViewModeling: AnyObject {
    var view: SpotlightCarouselViewing? { get set }
    var dataProvider: SpotlightCarouselDataProviding { get }
    func viewDidAppear()
}

final class SpotlightCarouselViewModel: NSObject, SpotlightCarouselViewModeling {
    weak var view: SpotlightCarouselViewing?
    
    var dataProvider: SpotlightCarouselDataProviding
    private var spotlights: [Spotlight]

    init(spotlights: [Spotlight], dataProvider: SpotlightCarouselDataProviding) {
        self.spotlights = spotlights
        self.dataProvider = dataProvider
        super.init()
        dataProvider.delegate = self
    }
    
    func viewDidAppear() {
        view?.reloadCollection()
    }
}

extension SpotlightCarouselViewModel: SpotlightCarouselDataProviderDelegate {
    func didSelectItem(_ name: String) {
        // TODO: Link to DetailsView
    }
}
