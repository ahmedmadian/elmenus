//
//  TagViewModel.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

class TagViewModel: TagViewModelType, TagViewModelInput, TagViewModelOutput {
    
    
    //Output
    var imageURL: Observable<String>
    var title: Observable<String>
    var isHidden: BehaviorSubject<Bool>


    init(with tag: Tag) {
        self.imageURL = Observable.just(tag.photoURL)
        self.title = Observable.just(tag.tagName)
        isHidden = BehaviorSubject<Bool>(value: true)
    }
}
