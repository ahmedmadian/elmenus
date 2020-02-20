//
//  Item.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

struct Item : Codable {
    let name : String
    let photoUrl : String
    let description : String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoUrl = "photoUrl"
        case description = "description"
    }
}
