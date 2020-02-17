//
//  ItemViewModel.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class ItemViewModel {
    let name: String
    let imageURL: String
    
    init(with item: Item) {
        self.name = item.name
        self.imageURL = item.photoUrl
    }
}
