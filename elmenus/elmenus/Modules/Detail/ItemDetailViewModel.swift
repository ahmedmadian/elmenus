//
//  ItemDetailViewModel.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

class ItemDetailViewModel: ItemDetailViewModelType, ItemDetailViewModelInput, ItemDetailViewModelOutput {
    
    // MARK: - Input
    var loaded: PublishSubject<Void>
    var back: PublishSubject<Void>
   
    // MARK: - Output
    var itemData: BehaviorRelay<ItemViewModel>
    
    // MARK: - Dependancies
    private let router: UnownedRouter<AppStartupRoute>
    
    init(router: UnownedRouter<AppStartupRoute>, data: ItemViewModel) {
        self.router = router
        
        /// Init Inputs
        self.loaded = PublishSubject<Void>().asObserver()
        self.back = PublishSubject<Void>().asObserver()
        
        /// Init Outputs
        self.itemData = BehaviorRelay<ItemViewModel>(value: data)
        
        _ = back.subscribe(onNext: {router.trigger(.exit)})
    }
}
