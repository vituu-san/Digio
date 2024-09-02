//
//  Carousel.swift
//  Digio
//
//  Created by Vitor Costa on 01/09/24.
//

import Foundation

struct Carousel {
    var items: [Item]
    var height: CGFloat
    var style: Style
    
    struct Item {
        var id: String
        var urlString: String
        var desc: String
    }
    
    enum Style: Equatable {
        case expanded
        case custom(width: CGFloat)
    }
}
