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
    func fetchTags(for pageNumber: Int) -> Observable<[Tag]>
    func save(tags: [OfflineTag], pageNumber: Int) -> Observable<Void>
    func getTagsfromLocal() -> Observable<[Tag]> 
    
}

class TagRepository: TagRepositoryProtocol {
    
    //MARK:- Properties
    private let remoteService: TagsRemoteServiceProtocol
    private let localService: TagLocalServiceProtocol
    
    // MARK:- Initializers
    init(remoteService: TagsRemoteServiceProtocol = TagsRemoteService.shared, localService: TagLocalServiceProtocol ) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func fetchTags(for pageNumber: Int) -> Observable<[Tag]> {
        let endPoint = ElmenusEndPoints.tags
        return remoteService.fetchTags(with: endPoint, params: String(pageNumber))
    }
    
    func save(tags: [OfflineTag], pageNumber: Int) -> Observable<Void> {
        let t = Observable.of(tags)
        return localService.add(tags: tags, for: pageNumber)
    }
    
    func getTagsfromLocal() -> Observable<[Tag]> {
        return localService.fetchTags()
    }
}
