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
    func fetchLocalTags() -> Observable<[Tag]>
    func save(tags: [OfflineTag])
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
    
    func fetchLocalTags() -> Observable<[Tag]> {
        return Observable.empty()
    }
    
    func save(tags: [OfflineTag]) {
        localService.add(tags: tags)
    }
}
