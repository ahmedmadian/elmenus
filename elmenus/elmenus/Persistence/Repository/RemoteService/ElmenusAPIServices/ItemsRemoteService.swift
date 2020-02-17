//
//  ItemsRemoteService.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol ItemsRemoteServiceProtocol: RemoteServiceProtocol {
    func fetchItems(with endPoint: Endpointed, params: String, completion: @escaping (([Item]?), Error?) -> ())
}


class ItemsRemoteService: ItemsRemoteServiceProtocol {
   
    
    //MARK:- Properties
    static let shared = ItemsRemoteService()
    
    // MARK:- Initializers
    private init() {}
    
    func fetchItems(with endPoint: Endpointed, params: String, completion: @escaping (([Item]?), Error?) -> ()) {
        
    }
}

