//
//  ItemLocalService.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/19/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import RxCoreData

protocol ItemLocalServiceProtocol {
    func add(items: [OfflineItem])
    func fetchItems(for tagName: String) -> Observable<[Item]>
}

class ItemLocalService: ItemLocalServiceProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func fetchItems(for tagName: String) -> Observable<[Item]> {
        let predicate = NSPredicate(format: "tagName == %@", tagName)
        let offlineItems = managedObjectContext.rx.entities(OfflineItem.self, predicate: predicate, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]).map {
            $0.map{ ($0)} }
        
        let res = offlineItems.map {$0.map {Item(name: $0.name, photoUrl: $0.imageURL, description: $0.itemDescription)}}
        return res
    }
    
    func add(items: [OfflineItem]) {
        _ = items.map { try? self.managedObjectContext.rx.update($0)}
    }
}
