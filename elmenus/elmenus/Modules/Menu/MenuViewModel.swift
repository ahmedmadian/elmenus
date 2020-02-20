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
import XCoordinator

class MenuViewModel: MenuViewModelType, MenuViewModelInput, MenuViewModelOutput {
    
    //MARK:-  Input
    var viewLoaded: PublishSubject<Void>
    var loadNextTags: PublishSubject<Void>
    var selectedItem: PublishSubject<ItemViewModel>
    var selectedTag: PublishSubject<TagViewModel>
    
    //MARK:- Output
    var tagsData: BehaviorRelay<[TagViewModel]>
    var itemsData: BehaviorRelay<[ItemViewModel]>
    var errorMessage: PublishSubject<String>
    var loading: Observable<Bool>
    
    // MARK: - Dependancies
    private var router: UnownedRouter<AppStartupRoute>
    private let tagsRepo: TagRepositoryProtocol
    private let itemsRepo: ItemRepositoryProtocol
    
    // MARK: Internal Fields
    private let currentPage = BehaviorRelay<Int>(value: 0)
    private let currentSerchTerm = BehaviorRelay(value: "")
    private var offlineMode = false
    private let fetchItems = PublishSubject<Void>()
    
    init(router: UnownedRouter<AppStartupRoute>, tagsRepo: TagRepositoryProtocol, itemsRepo: ItemRepositoryProtocol) {
        ///init dependancies
        self.router = router
        self.tagsRepo = tagsRepo
        self.itemsRepo = itemsRepo
        
        /// init Inputs
        self.viewLoaded = PublishSubject<Void>()
        self.loadNextTags =  PublishSubject<Void>()
        self.selectedItem = PublishSubject<ItemViewModel>().asObserver()
        self.selectedTag = PublishSubject<TagViewModel>().asObserver()
        
        /// init Outputs
        tagsData = BehaviorRelay<[TagViewModel]>(value: [])
        itemsData = BehaviorRelay<[ItemViewModel]>(value: [])
        errorMessage = PublishSubject<String>()
       
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        
        let loadTags = viewLoaded.flatMapLatest { _ -> Observable<[TagViewModel]> in
            return self.tagsRepo.fetchTags(for: self.currentPage.value + 1)
                .catchError { error in
                    self.offlineMode = true
                    self.errorMessage.onNext(error.localizedDescription)
                    return self.tagsRepo.fetchLocalTags()
            }
            .trackActivity(activityIndicator)
            .map { $0.map { TagViewModel(with: $0) }}
        }
        
        let loadMoreTags = loadNextTags.debounce( RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest { _ -> Observable<[TagViewModel]> in
                self.currentPage.accept(self.currentPage.value + 1)
                return self.tagsRepo.fetchTags(for: self.currentPage.value + 1)
                    .catchError { error in
                        self.errorMessage.onNext(error.localizedDescription)
                        return self.tagsRepo.fetchLocalTags()
                }
                .map { $0.map { TagViewModel(with: $0) }}
        }
        
        _ = loadTags.subscribe(onNext:  {
            if !self.offlineMode  {
                let offlineTags = $0.map {OfflineTag(name: try! $0.title.value(), imageURL: try! $0.imageURL.value(), page: Int32(self.currentPage.value))}
                self.tagsRepo.save(tags: offlineTags)
            }
            self.tagsData.accept(self.tagsData.value + $0)
            if $0.count > 0 { self.selectedTag.onNext($0[0])}
        })
        
        _ = loadMoreTags.subscribe(onNext:  {
            if !self.offlineMode  {
                let offlineTags = $0.map {OfflineTag(name: try! $0.title.value(), imageURL: try! $0.imageURL.value(), page: Int32(self.currentPage.value))}
                self.tagsRepo.save(tags: offlineTags)
            }
            self.tagsData.accept(self.tagsData.value + $0)
            })
        
        let loadItems = fetchItems.flatMapLatest { _ -> Observable<[ItemViewModel]> in
            return self.itemsRepo.fetchItems(for: self.currentSerchTerm.value)
                .catchError { error in
                    self.errorMessage.onNext(error.localizedDescription)
                    return self.itemsRepo.fetchLocalItems(for: self.currentSerchTerm.value)
            }
            .trackActivity(activityIndicator)
            .map { $0.map { ItemViewModel(with: $0) }}
        }
        
        _ = loadItems.subscribe(onNext:  {
            if !self.offlineMode  {
                let offlineItems = $0.map{ OfflineItem(name: $0.name, imageURL: $0.imageURL, itemDescription: $0.description, tagName: self.currentSerchTerm.value)}
                self.itemsRepo.save(items: offlineItems)
            }
            self.itemsData.accept($0)
        })
        
        _ = selectedTag.subscribe(onNext: {
            self.currentSerchTerm.accept(try!$0.title.value())
            self.fetchItems.onNext(())
        })
        
        _ = selectedItem.subscribe(onNext: {router.trigger(.detail($0))})
        
    }
    
}
