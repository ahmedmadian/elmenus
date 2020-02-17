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
    func fetchItems(for tagName: String, completion: @escaping (([Item]?), Error?) -> ())
     func fetchItems(for tagName: String) -> Observable<[Item]>
}

class ItemRepository: ItemRepositoryProtocol {
    
    //MARK:- Properties
    private let remoteService: ItemsRemoteServiceProtocol
    
    // MARK:- Initializers
    init(remoteService: ItemsRemoteServiceProtocol = ItemsRemoteService.shared) {
        self.remoteService = remoteService
    }
    
    func fetchItems(for tagName: String) -> Observable<[Item]> {
//        let endPoint = ElmenusEndPoints.items
//        return remoteService.fetchItems(with: endPoint, params: tagName)
        return TempDataSource.shared.fetchItems()
    }
    
    func fetchItems(for tagName: String, completion: @escaping (([Item]?), Error?) -> ()) {
        let endPoint = ElmenusEndPoints.items
        remoteService.fetchItems(with: endPoint, params: tagName, completion: completion)
    }
    
    
}
