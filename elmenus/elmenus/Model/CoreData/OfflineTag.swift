//
//  OfflineTag.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/18/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct OfflineTag {
    var name: String
    var imageURL: String
}

extension OfflineTag : Persistable {
    var identity: String {
        return name
    }
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "OfflineTag"
    }
    
    static var primaryAttributeName: String {
        return "name"
    }
    
    init(entity: T) {
        name = entity.value(forKey: "name") as! String
        imageURL = entity.value(forKey: "imageURL") as! String
    }
    
    func update(_ entity: T) {
        entity.setValue(name, forKey: "name")
        entity.setValue(imageURL, forKey: "imageURL")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
