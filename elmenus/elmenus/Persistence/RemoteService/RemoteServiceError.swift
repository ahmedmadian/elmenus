//
//  RemoteServiceError.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum RemoteServiceError: LocalizedError {
    case parsingError
    case serverError(message: String, code: Int)
    
    var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Failure"
        case .serverError(let message): return "\(message)<\(code)>"
        }
    }
}
