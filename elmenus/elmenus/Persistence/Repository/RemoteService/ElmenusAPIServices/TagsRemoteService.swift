//
//  TagsRemoteService.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol TagsRemoteServiceProtocol: RemoteServiceProtocol {
    func fetchTags(with endPoint: Endpointed, params: String) -> Observable<[Tag]>
    func fetchTags(with endPoint: Endpointed, params: String, completion: @escaping (([Tag]?), Error?) -> ())
}


class TagsRemoteService: TagsRemoteServiceProtocol {
   
    //MARK:- Properties
    static let shared = TagsRemoteService()
    
    // MARK:- Initializers
    private init() {}
    
    func fetchTags(with endPoint: Endpointed, params: String) -> Observable<[Tag]> {
        return Observable.create { observer in
            self.execute(endPoint: endPoint, queryParams: params) { (result: Result<TagsWrapper, RemoteServiceError>) in
                switch result {
                case .success(let response):
                    observer.on(.next(response.tags))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchTags(with endPoint: Endpointed, params: String, completion: @escaping (([Tag]?), Error?) -> ()) {
        self.execute(endPoint: endPoint, queryParams: params) { (result: Result<TagsWrapper, RemoteServiceError>) in
            switch result {
            case .success(let response):
                completion(response.tags, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
       
}

