//
//  ItemsRemoteService.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemsRemoteServiceProtocol: RemoteServiceProtocol {
    func fetchItems(with endPoint: Endpointed, params: String, completion: @escaping (([Item]?), Error?) -> ())
     func fetchItems(with endPoint: Endpointed, params: String) -> Observable<[Item]>
}


class ItemsRemoteService: ItemsRemoteServiceProtocol {
   
    
   
    
    //MARK:- Properties
    static let shared = ItemsRemoteService()
    
    // MARK:- Initializers
    private init() {}
    
    func fetchItems(with endPoint: Endpointed, params: String, completion: @escaping (([Item]?), Error?) -> ()) {
        
    }
    
    func fetchItems(with endPoint: Endpointed, params: String) -> Observable<[Item]> {
        return Observable.create { observer in
            self.execute(endPoint: endPoint, queryParams: params) { (result: Result<ItemsWrapper, RemoteServiceError>) in
                switch result {
                case .success(let response):
                    observer.on(.next(response.items))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}

