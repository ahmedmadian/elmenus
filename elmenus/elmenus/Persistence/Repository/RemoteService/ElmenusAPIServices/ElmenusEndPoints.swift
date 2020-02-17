//
//  ElmenusEndPoints.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum ElmenusEndPoints: String, Endpointed {
    case tags
    case items
    
    var path: String {
        switch self {
        case .tags:
            return self.rawValue
        case .items :
            return self.rawValue
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .tags:
            return .get
        case .items:
            return .post
        }
    }
}
