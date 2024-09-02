//
//  CashModel.swift
//  Digio
//
//  Created by Vitor Costa on 28/08/24.
//

import Foundation

struct Cash: Decodable {
    var title: String
    var banner: String
    var desc: String

    private enum CodingKeys: String, CodingKey {
        case title
        case banner = "bannerURL"
        case desc = "description"
    }
    
    func carouselItem() -> Carousel.Item {
        .init(id: title, urlString: banner, desc: desc)
    }
}
