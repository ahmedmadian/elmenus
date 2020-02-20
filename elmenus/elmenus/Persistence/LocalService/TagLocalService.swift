//
//  TagLocalService.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/18/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import RxCoreData

protocol TagLocalServiceProtocol {
    func add(tags: [OfflineTag])
    func fetchTags() -> Observable<[Tag]>
}

class TagLocalService: TagLocalServiceProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func fetchTags() -> Observable<[Tag]> {
        let offlineTags = managedObjectContext.rx.entities(OfflineTag.self, predicate: nil, sortDescriptors: [NSSortDescriptor(key: "page", ascending: true)]).map {
            $0.map{ ($0)} }
                
        let res = offlineTags.map{ $0.map {Tag(tagName: $0.name, photoURL: $0.imageURL)}}
        return res
    }
    
    func add(tags: [OfflineTag]) {
        _ = tags.map { try? self.managedObjectContext.rx.update($0)}
    }
}
