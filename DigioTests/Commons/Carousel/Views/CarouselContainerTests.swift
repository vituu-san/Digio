//
//  SpotlightCarouselContainerTests.swift
//  DigioTests
//
//  Created by Vitor Costa on 01/09/24.
//

import XCTest
import SnapKit
import SnapshotTesting

@testable import Digio

final class CarouselContainerTests: XCTestCase {
    private var sut: CarouselContainer!
    private var viewModelMock: CarouselViewModeling!
    private var dataProviderMock: CarouselDataProviderMock!
    private var sessionMock: URLSessionMock!

    override func setUp() {
        sessionMock = URLSessionMock()
        
        let spotlights = [Spotlight.placeholder, Spotlight.placeholder]
        let carousel = Carousel(items: spotlights.map({ $0.carouselItem() }),
                                height: 150,
                                style: .expanded)
        
        dataProviderMock = CarouselDataProviderMock(carousel: carousel,
                                                    session: sessionMock)

        viewModelMock = CarouselViewModelMock(dataProvider: dataProviderMock,
                                              carousel: carousel)
        
        sut = CarouselContainer(viewModel: viewModelMock)
        viewModelMock.view = sut
    }

    override func tearDown() {
        dataProviderMock = nil
        viewModelMock = nil
        sessionMock = nil
        sut = nil
    }

    func testInit_WhenInstantiation_ShouldPresentSpotlights() {
        let imageData = UIImage(named: "recharge-banner")?.pngData()
        sessionMock.data = imageData
        
        let sut = CarouselContainer(viewModel: viewModelMock)
        viewModelMock.view = sut

        let controller = UIViewController()

        controller.view.addSubview(sut)

        sut.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        controller.viewDidLoad()

        wait(for: "Load Spotlight Carousel.", during: 3)

        assertSnapshot(of: controller, as: .image)
    }
}

extension Spotlight {
    static var placeholder: Self {
        Spotlight(name: "Recarga",
                  banner: "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png",
                  desc: "Agora ficou mais fácil colocar créditos no seu celular!")
    }
}
