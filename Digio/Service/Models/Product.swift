//
//  ProductModel.swift
//  Digio
//
//  Created by Vitor Costa on 28/08/24.
//

import Foundation

struct Product: Decodable {
    var name: String
    var image: String
    var desc: String

    enum CodingKeys: String, CodingKey {
        case name
        case image = "imageURL"
        case desc = "description"
    }
}
