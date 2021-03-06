//
//  RemoteServiceProtocol.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import Alamofire

protocol RemoteServiceProtocol {
    func execute<Model:Codable>(endPoint: Endpointed, queryParams: String, completionHandler: @escaping (Swift.Result<Model, Error>) -> Void )
    
}

extension RemoteServiceProtocol {
    
    func execute<Model:Codable>(endPoint: Endpointed, queryParams: String, completionHandler: @escaping (Swift.Result<Model, Error>) -> Void ) {
        
        
        let endpointUrl = "\(endPoint.base)/\(endPoint.path)/\(queryParams)"
        
        Alamofire.request(endpointUrl, method: Alamofire.HTTPMethod.init(rawValue: endPoint.method.rawValue)!, parameters: nil, headers: nil).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    completionHandler(Swift.Result.success(object))
                }
                catch {
                    completionHandler(Swift.Result.failure(RemoteServiceError.parsingError))
                }
            case .failure(let error):
                completionHandler(Swift.Result.failure(RemoteServiceError.serverError(message: error.localizedDescription, code: error.code)))
            }
        }
    }
}
