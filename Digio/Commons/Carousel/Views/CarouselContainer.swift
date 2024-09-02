//
//  SpotilightCarouselContainer.swift
//  Digio
//
//  Created by Vitor Costa on 31/08/24.
//

import UIKit
import SnapKit

protocol CarouselViewing: AnyObject {
    var viewModel: CarouselViewModeling { get }
    func reloadCollection()
}

final class CarouselContainer: UIView, CarouselViewing {
    var viewModel: CarouselViewModeling

    private lazy var collection: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CarouselCell.self,
                            forCellWithReuseIdentifier: viewModel.dataProvider.reuseIdentifier)
        collection.dataSource = viewModel.dataProvider
        collection.delegate = viewModel.dataProvider
        collection.showsHorizontalScrollIndicator = false
        collection.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return collection
    }()

    init(viewModel: CarouselViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        buildViewHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubview(collection)
    }
    
    func setupConstraints() {
        collection.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collection.layoutIfNeeded()
            self?.setupLayout()
        }
    }
    
    private func setupLayout() {
        if let flow = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            var width: CGFloat = 0
            
            switch viewModel.carousel.style {
            case .custom(let value):
                width = value
            case .expanded:
                width = frame.width - (frame.width / 10)
            }
            
            flow.itemSize = CGSize(width: width, height: viewModel.carousel.height)
        }
    }
}
