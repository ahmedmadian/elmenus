//
//  TagsRemoteService.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol TagsRemoteServiceProtocol: RemoteServiceProtocol {
    func fetchTags(with endPoint: Endpointed, params: String, completion: @escaping (([Tag]?), Error?) -> ())
}


class TagsRemoteService: TagsRemoteServiceProtocol {
   
   
    
    
    //MARK:- Properties
    static let shared = TagsRemoteService()
    
    // MARK:- Initializers
    private init() {}
    
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

