//
//  SandboxModel.swift
//  Digio
//
//  Created by Vitor Costa on 28/08/24.
//

import Foundation

struct Sandbox: Decodable {
    var spotlight: [Spotlight]
    var products: [Product]
    var cash: Cash
}
