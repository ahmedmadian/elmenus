//
//  TagRepository.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol TagRepositoryProtocol {
    func fetchTags(for pageNumber: Int, completion: @escaping (([Tag]?), Error?) -> ())
    func fetchTags(for pageNumber: Int) -> Observable<[Tag]>

}

class TagRepository: TagRepositoryProtocol {
    
    //MARK:- Properties
    private let remoteService: TagsRemoteServiceProtocol
    
    // MARK:- Initializers
    init(remoteService: TagsRemoteServiceProtocol = TagsRemoteService.shared) {
        self.remoteService = remoteService
    }
    
    func fetchTags(for pageNumber: Int) -> Observable<[Tag]> {
        let endPoint = ElmenusEndPoints.tags
        return remoteService.fetchTags(with: endPoint, params: String(pageNumber))
    }
    
    func fetchTags(for pageNumber: Int, completion: @escaping (([Tag]?), Error?) -> ()) {
        let endPoint = ElmenusEndPoints.tags
        remoteService.fetchTags(with: endPoint, params: String(pageNumber), completion: completion)
    }
}
