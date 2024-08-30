//
//  SpotlightModel.swift
//  Digio
//
//  Created by Vitor Costa on 28/08/24.
//

import Foundation

struct Spotlight: Decodable {
    var name: String
    var banner: String
    var desc: String

    enum CodingKeys: String, CodingKey {
        case name
        case banner = "bannerURL"
        case desc = "description"
    }
}
