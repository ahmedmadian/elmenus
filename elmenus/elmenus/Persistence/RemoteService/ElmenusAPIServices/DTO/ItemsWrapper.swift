//
//  ItemsWrapper.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

struct ItemsWrapper : Codable {
    let items : [Item]

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}
