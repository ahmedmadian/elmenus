//
//  AppStartupCoordinator.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

class AppStartupCoordinator: NavigationCoordinator<AppStartupRoute> {
    
    init() {
        super.init(initialRoute: .menu)
    }
    
    ///manage modules transition
    override func prepareTransition(for route: AppStartupRoute) -> NavigationTransition {
        switch route {
       
        case .menu:
            let tagRepo = TagRepository()
            let itemRepo = ItemRepository()
            let viewModel = MenuViewModel(tagsRepo: tagRepo, itemsRepo: itemRepo)
            let controller: MenuViewController  = Storyboards.main.instantiate()!
            controller.bind(to: viewModel)
            return .push(controller)
            
        default:
            return .dismissToRoot()
        }
    }
}
