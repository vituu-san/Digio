//
//  SpotilightCarouselContainer.swift
//  Digio
//
//  Created by Vitor Costa on 31/08/24.
//

import UIKit
import SnapKit

protocol SpotlightCarouselViewing: AnyObject {
    var viewModel: SpotlightCarouselViewModeling { get }
    func reloadCollection()
}

final class SpotlightCarouselContainer: UIView, SpotlightCarouselViewing {
    var viewModel: SpotlightCarouselViewModeling

    private lazy var collection: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SpotlightCarouselCell.self,
                            forCellWithReuseIdentifier: "SpotlightCarouselCell")
        collection.dataSource = viewModel.dataProvider
        collection.delegate = viewModel.dataProvider
        collection.showsHorizontalScrollIndicator = false
        collection.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return collection
    }()

    init(viewModel: SpotlightCarouselViewModeling) {
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
            flow.itemSize = CGSize(width: frame.width - (frame.width / 10), height: 150)
        }
    }
}
