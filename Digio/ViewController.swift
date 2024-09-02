//
//  ViewController.swift
//  Digio
//
//  Created by Vitor Costa on 27/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var spotligthViewModel: CarouselViewModeling = {
        let spotlights = [Spotlight(name: "Recarga",
                                    banner: "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png",
                                    desc: "Agora ficou mais fácil colocar créditos no seu celular!"),
                          Spotlight(name: "Uber",
                                    banner: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
                                    desc: "Dê um vale presente Uber para amigos e familiares.")]
        
        let items = spotlights.map { $0.carouselItem() }
        let carousel = Carousel(items: items, height: 150, style: .expanded)
        let dataProvider = CarouselDataProvider(reuseIdentifier: "SpotlightCarousel",
                                                carousel: carousel)
        let viewModel = CarouselViewModel(carousel: carousel, dataProvider: dataProvider)
        
        return viewModel
    }()
    
    private var productsViewModel: CarouselViewModeling = {
        let products = [Product(name: "XBOX",
                                  image: "https://s3-sa-east-1.amazonaws.com/digio-exame/xbox_icon.png",
                                  desc: "Com o e-Gift Card Xbox você adquire créditos para comprar games, música, filmes, programas de TV e muito mais!"),
                          Product(name: "Google Play",
                                  image: "https://s3-sa-east-1.amazonaws.com/digio-exame/google_play_icon.png",
                                  desc: "O e-gift Google Play dá acesso a um mundo de entretenimento."),
                          Product(name: "Level up",
                                  image: "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png",
                                  desc: "Com o e-Gift Card Level Up você adquire créditos para jogar diversas opções de games.")]
        
        let items = products.map { $0.carouselItem() }
        let carousel = Carousel(items: items, height: 100, style: .custom(width: 100))
        let dataProvider = CarouselDataProvider(reuseIdentifier: "ProductsCarousel",
                                                carousel: carousel)
        let viewModel = CarouselViewModel(carousel: carousel, dataProvider: dataProvider)
        
        return viewModel
    }()
    
    private var cashViewModel: CarouselViewModeling = {
        let cash = [Cash(title: "digio Cash",
                          banner: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png",
                          desc: "Dinheiro na conta sem complicação. Transfira parte do limite do seu cartão para sua conta.")]
        
        let items = cash.map { $0.carouselItem() }
        let carousel = Carousel(items: items, height: 100, style: .expanded)
        let dataProvider = CarouselDataProvider(reuseIdentifier: "CashCarousel",
                                                carousel: carousel)
        let viewModel = CarouselViewModel(carousel: carousel, dataProvider: dataProvider)
        
        return viewModel
    }()
    
    private lazy var spotlightCarouselView: CarouselContainer = {
        let carouselView = CarouselContainer(viewModel: spotligthViewModel)
        return carouselView
    }()
    
    private lazy var productsCarouselView: CarouselContainer = {
        let carouselView = CarouselContainer(viewModel: productsViewModel)
        return carouselView
    }()
    
    private lazy var cashCarouselView: CarouselContainer = {
        let carouselView = CarouselContainer(viewModel: cashViewModel)
        return carouselView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerView = UIView(frame: .zero)
        
        centerView.addSubview(spotlightCarouselView)
        centerView.addSubview(productsCarouselView)
        centerView.addSubview(cashCarouselView)
        
        view.addSubview(centerView)
        
        spotlightCarouselView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(150)
            $0.leading.trailing.equalToSuperview()
        }
        
        productsCarouselView.snp.makeConstraints {
            $0.top.equalTo(spotlightCarouselView.snp.bottom).offset(12)
            $0.height.equalTo(100)
            $0.leading.trailing.equalToSuperview()
        }
        
        cashCarouselView.snp.makeConstraints {
            $0.top.equalTo(productsCarouselView.snp.bottom).offset(12)
            $0.height.equalTo(100)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        centerView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
        }
        
        spotligthViewModel.view = spotlightCarouselView
        productsViewModel.view = productsCarouselView
        cashViewModel.view = cashCarouselView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spotligthViewModel.viewDidAppear()
        productsViewModel.viewDidAppear()
        cashViewModel.viewDidAppear()
    }
}
