//
//  TagsWrapper.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

struct TagsWrapper : Codable {
    let tags : [Tag]

    enum CodingKeys: String, CodingKey {
        case tags = "tags"
    }
}
