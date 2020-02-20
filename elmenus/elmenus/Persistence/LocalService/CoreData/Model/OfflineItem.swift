//
//  OfflineItem.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/19/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct OfflineItem {
    //var id: Int32
    var name: String
    var imageURL: String
    var itemDescription: String
    var tagName: String
}

extension OfflineItem : Persistable {
    var identity: String {
        return name
    }
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "OfflineItem"
    }
    
    static var primaryAttributeName: String {
        return "name"
    }
    
    init(entity: T) {
        //id = entity.value(forKey: "id") as! Int32
        name = entity.value(forKey: "name") as! String
        imageURL = entity.value(forKey: "imageURL") as! String
        itemDescription = entity.value(forKey: "itemDescription") as! String
        tagName = entity.value(forKey: "tagName") as! String
    }
    
    func update(_ entity: T) {
        //entity.setValue(id, forKey: "id")
        entity.setValue(name, forKey: "name")
        entity.setValue(imageURL, forKey: "imageURL")
        entity.setValue(itemDescription, forKey: "itemDescription")
        entity.setValue(tagName, forKey: "tagName")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}

