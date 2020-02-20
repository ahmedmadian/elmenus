//
//  TagViewModel.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TagViewModel: TagViewModelType, TagViewModelInput, TagViewModelOutput {
    
    // MARK: - Output
    var imageURL: BehaviorSubject<String>
    var title: BehaviorSubject<String>
    var isBorderHidden: BehaviorRelay<Bool>

    init(with tag: Tag) {
        self.imageURL = BehaviorSubject<String>(value: tag.photoURL)
        self.title = BehaviorSubject<String>(value: tag.tagName)
        isBorderHidden = BehaviorRelay<Bool>(value: true)
    }
}
