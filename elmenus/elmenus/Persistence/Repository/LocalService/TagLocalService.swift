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
    //func add(tags: Observable<[Tag]> ) -> Observable<Void>
    func add(tags: [OfflineTag], for page: Int) -> Observable<Void>
    func fetchTags() -> Observable<[Tag]>
}

class TagLocalService: TagLocalServiceProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func fetchTags() -> Observable<[Tag]> {
        let predicate = NSPredicate(format: "page == %@", "1")
        let offlineTags = managedObjectContext.rx.entities(OfflineTag.self, predicate: predicate, sortDescriptors: [NSSortDescriptor(key: "page", ascending: false)]).map {
            $0.map{ ($0)} }
                
        let res = offlineTags.map{ $0.map {Tag(tagName: $0.name, photoURL: $0.imageURL)}}
        return res
    }
    
    func add(tags: [OfflineTag], for page: Int) -> Observable<Void> {
        _ = tags.map { try? self.managedObjectContext.rx.update($0)}
        //_ = tags.map {$0.map {try? self.managedObjectContext.rx.update($0)}}
        return Observable.just(Void())
    }
}
