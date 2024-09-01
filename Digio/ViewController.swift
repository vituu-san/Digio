//
//  ViewController.swift
//  Digio
//
//  Created by Vitor Costa on 27/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var carouselViewModel: SpotlightCarouselViewModel = {
        let spotlights = [Spotlight(name: "Recarga",
                                    banner: "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png",
                                    desc: "Agora ficou mais fácil colocar créditos no seu celular!"),
                          Spotlight(name: "Uber",
                                    banner: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
                                    desc: "Dê um vale presente Uber para amigos e familiares.")]
        
        let dataProvider = SpotlightCarouselDataProvider(spotlights: spotlights)
        let viewModel = SpotlightCarouselViewModel(spotlights: spotlights, dataProvider: dataProvider)
        return viewModel
    }()
    
    private lazy var carouselView: SpotlightCarouselContainer = {
        let carouselView = SpotlightCarouselContainer(viewModel: carouselViewModel)
        return carouselView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(carouselView)
        
        carouselView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        carouselViewModel.view = carouselView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselViewModel.viewDidAppear()
    }
}
