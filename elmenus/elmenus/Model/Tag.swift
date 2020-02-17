//
//  Tag.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

struct Tag : Codable {
    let tagName : String?
    let photoURL : String?

    enum CodingKeys: String, CodingKey {
        case tagName = "tagName"
        case photoURL = "photoURL"
    }

}
