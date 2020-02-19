//
//  Endpointed.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol Endpointed {
    var path: String { get }
    var base: String { get }
    var method: HTTPMethod { get }
}

extension Endpointed {
    var base: String {
        return AppConstants.defaultBaseUrl
    }
}
