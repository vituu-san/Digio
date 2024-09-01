//
//  SpotlightCarouselCell.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import UIKit

final class SpotlightCarouselCell: UICollectionViewCell {
    private var backView = UIView()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImage(with bannerUrl: String) {
        imageView.loadCachedImage(with: bannerUrl)
    }
    
    func buildViewHierarchy() {
        backView.addSubview(imageView)
        contentView.addSubview(backView)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    func setupLayout() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        backView.layer.shadowRadius = 4
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOpacity = 0.3
        backView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        backView.translatesAutoresizingMaskIntoConstraints = false
    }
}
