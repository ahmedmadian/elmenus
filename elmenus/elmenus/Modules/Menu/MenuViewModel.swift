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
    var loadNextTags: PublishSubject<Void>
    
    //MARK:- Output
    var tagsData: BehaviorRelay<[TagViewModel]>
    var itemsData: BehaviorRelay<[ItemViewModel]>
    
    //MARK: Fields
    private let tagsRepo: TagRepositoryProtocol
    private let itemsRepo: ItemRepositoryProtocol
  
    let currentPage = BehaviorRelay<Int>(value: 0)

    init(tagsRepo: TagRepositoryProtocol, itemsRepo: ItemRepositoryProtocol) {
        self.tagsRepo = tagsRepo
        self.itemsRepo = itemsRepo
        
        /// Used to start load when view load
        self.loaded = PublishSubject<Void>()
        
        /// Used to fetch next data page
        self.loadNextTags =  PublishSubject<Void>()
        
        tagsData = BehaviorRelay<[TagViewModel]>(value: [])
        itemsData = BehaviorRelay<[ItemViewModel]>(value: [])
        
        let moreTags = loadNextTags.flatMapLatest { _ -> Observable<[TagViewModel]> in
            self.currentPage.accept(self.currentPage.value + 1)
             return self.tagsRepo.fetchTags(for: self.currentPage.value + 1)
                .map { $0.map { TagViewModel(with: $0) }}
        }
        
        let loadTags = loaded.flatMapLatest { _ -> Observable<[TagViewModel]> in
            return self.tagsRepo.fetchTags(for: self.currentPage.value + 1).map { $0.map { TagViewModel(with: $0) }}
        }
        
        let loadItems = loaded.flatMapLatest { _ -> Observable<[ItemViewModel]> in
            return self.itemsRepo.fetchItems(for: "2Desert").map { $0.map { ItemViewModel(with: $0) }}
        }
        
        _ = loadTags.subscribe(onNext: { (tags) in
            self.tagsData.accept(self.tagsData.value + tags)
        })
        
        _ = moreTags.subscribe(onNext: { (tags) in
            self.tagsData.accept(self.tagsData.value + tags)
        })
        
        _ = loadItems.subscribe(onNext: { (items) in
            self.itemsData.accept(self.itemsData.value + items)
        })
        
    }
    
}
