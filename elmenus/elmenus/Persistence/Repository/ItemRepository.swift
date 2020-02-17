//
//  ItemRepository.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol ItemRepositoryProtocol {
    func fetchItems(for tagName: String, completion: @escaping (([Item]?), Error?) -> ())
}

class ItemRepository: ItemRepositoryProtocol {
    
    //MARK:- Properties
    private let remoteService: ItemsRemoteServiceProtocol
    
    // MARK:- Initializers
    init(remoteService: ItemsRemoteServiceProtocol = ItemsRemoteService.shared) {
        self.remoteService = remoteService
    }
    
    func fetchItems(for tagName: String, completion: @escaping (([Item]?), Error?) -> ()) {
        let endPoint = ElmenusEndPoints.items
        remoteService.fetchItems(with: endPoint, params: tagName, completion: completion)
    }
    
    
}
