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
    func fetchItems() -> Observable<[Item]>
}

class ItemLocalService: ItemLocalServiceProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func fetchItems() -> Observable<[Item]> {
        return Observable.empty()
    }
    
    func add(items: [OfflineItem]) {
        _ = items.map { try? self.managedObjectContext.rx.update($0)}
    }
}
