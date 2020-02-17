//
//  Temp.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
protocol LocalDataSource {
    func fetchDataFrom<Model:Codable>(resource fileName: String, ofType type:String) -> Model?
}

extension LocalDataSource {
   
    func fetchDataFrom<Model:Codable>(resource fileName: String, ofType type:String) -> Model? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else {return nil}
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe) else {return nil}
        guard let item = try? JSONDecoder().decode(Model.self, from: data) else {return nil}
        return item
    }
}

protocol TempDataSourceProtocol: LocalDataSource {
    func fetchItems() -> Observable<[Item]>
}

final class TempDataSource:  TempDataSourceProtocol{
   
    //MARK:- Properties
    static let shared = TempDataSource()
    
    private let fileName = "TempData"
    private let fileType = "json"
    
    // MARK:- Initializers
    private init() {}
    
    func fetchItems() -> Observable<[Item]> {
            let dto: ItemsWrapper = self.fetchDataFrom(resource: fileName, ofType: fileType)!
           return Observable.of(dto.items)
       }
       
       
    
}

