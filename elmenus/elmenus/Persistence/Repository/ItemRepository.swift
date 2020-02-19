//
//  ItemRepository.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemRepositoryProtocol {
    func fetchItems(for tagName: String) -> Observable<[Item]>
    func fetchLocalItems() -> Observable<[Item]>
    func save(items: [OfflineItem])
}

class ItemRepository: ItemRepositoryProtocol {
    
    //MARK:- Properties
    private let remoteService: ItemsRemoteServiceProtocol
    
    // MARK:- Initializers
    init(remoteService: ItemsRemoteServiceProtocol = ItemsRemoteService.shared) {
        self.remoteService = remoteService
    }
    
    func fetchItems(for tagName: String) -> Observable<[Item]> {
        let endPoint = ElmenusEndPoints.items
        let formattedString = tagName.replacingOccurrences(of: " ", with: "")
        return remoteService.fetchItems(with: endPoint, params: formattedString)
    }
    
    func fetchLocalItems() -> Observable<[Item]> {
        return Observable.empty()
    }
    
    func save(items: [OfflineItem]) {
        
    }
}
