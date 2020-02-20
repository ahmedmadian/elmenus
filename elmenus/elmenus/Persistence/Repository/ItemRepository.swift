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
    func fetchLocalItems(for tagName: String) -> Observable<[Item]>
    func save(items: [OfflineItem])
}

class ItemRepository: ItemRepositoryProtocol {
    
    //MARK:- Properties
    private let remoteService: ItemsRemoteServiceProtocol
    private let localService: ItemLocalServiceProtocol
    
    // MARK:- Initializers
    init(remoteService: ItemsRemoteServiceProtocol = ItemsRemoteService.shared, localService: ItemLocalServiceProtocol) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func fetchItems(for tagName: String) -> Observable<[Item]> {
        let endPoint = ElmenusEndPoints.items
        let formattedString = tagName.replacingOccurrences(of: " ", with: "")
        return remoteService.fetchItems(with: endPoint, params: formattedString)
    }
    
    func fetchLocalItems(for tagName: String) -> Observable<[Item]> {
        return localService.fetchItems(for: tagName)
    }
    
    func save(items: [OfflineItem]) {
        localService.add(items: items)
    }
}
