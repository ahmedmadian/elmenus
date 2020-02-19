//
//  DataController.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/19/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    // MARK:- Singleton
    static let shared: DataController = DataController()
    
    // MARK:- Properties
    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "elmenus")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let persistentContainerLoadError = error {
                fatalError("Unresolved error \(persistentContainerLoadError), \(persistentContainerLoadError.userInfo)")
            }
        })
        return container
    }()
    
    

}
