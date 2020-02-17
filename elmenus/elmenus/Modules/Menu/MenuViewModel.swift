//
//  MenuViewModel.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MenuViewModel: MenuViewModelType, MenuViewModelInput, MenuViewModelOutput {
 
    
    
    //MARK:-  Input
    var loaded: PublishSubject<Void>
    
    //MARK:- Output
    var tagsData: Observable<[TagViewModel]>
    var itemsData: Observable<[ItemViewModel]>
    
    init() {
        self.loaded = PublishSubject<Void>().asObserver()
        
        let loadedTags = BehaviorRelay<[TagViewModel]>(value: [])
        tagsData = loadedTags.asObservable()
        
        let loadedItems =  BehaviorRelay<[ItemViewModel]>(value: [])
        itemsData = loadedItems.asObservable()
    }
    
}
