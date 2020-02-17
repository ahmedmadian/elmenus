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
    
    //MARK: Fields
    private let tagsRepo: TagRepositoryProtocol
    private let itemsRepo: ItemRepositoryProtocol

    init(tagsRepo: TagRepositoryProtocol, itemsRepo: ItemRepositoryProtocol) {
        self.tagsRepo = tagsRepo
        self.itemsRepo = itemsRepo
        
        self.loaded = PublishSubject<Void>().asObserver()
        
        let loadedTags = BehaviorRelay<[TagViewModel]>(value: [])
        tagsData = loadedTags.asObservable()
        
        let loadedItems =  BehaviorRelay<[ItemViewModel]>(value: [])
        itemsData = loadedItems.asObservable()
        
        self.tagsData = loadedTags.flatMapLatest { _ -> Observable<[TagViewModel]> in
            return self.tagsRepo.fetchTags(for: 1).map { $0.map { TagViewModel(with: $0) }}
        }
        
        self.itemsData = loadedItems.flatMapLatest { _ -> Observable<[ItemViewModel]> in
            return self.itemsRepo.fetchItems(for: "2Desert").map { $0.map { ItemViewModel(with: $0) }}
        }
    }
    
}
