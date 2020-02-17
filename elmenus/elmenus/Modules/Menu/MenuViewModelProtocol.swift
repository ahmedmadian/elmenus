//
//  MenuViewModelProtocol.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol MenuViewModelInput {
}

protocol MenuViewModelOutput {
}

protocol MenuViewModelType {
    var input: MenuViewModelInput { get }
    var output: MenuViewModelOutput { get }
}

extension MenuViewModelType where Self: MenuViewModelInput & MenuViewModelOutput {
    var input: MenuViewModelInput { return self }
    var output: MenuViewModelOutput { return self }
}
