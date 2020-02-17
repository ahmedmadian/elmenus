//
//  TagViewModel.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class TagViewModel {
    let imageURL: String
    let title: String
    
    init(with tag: Tag) {
        self.imageURL = tag.photoURL
        self.title = tag.tagName
    }
}
