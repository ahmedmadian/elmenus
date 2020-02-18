//
//  TagViewModelProtocol.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/18/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol TagViewModelInput {
}

protocol TagViewModelOutput {
    var title: Observable<String> {get}
    var imageURL: Observable<String> {get}
    var isHidden: BehaviorSubject<Bool> { get }

}

protocol TagViewModelType {
    var input: TagViewModelInput { get }
    var output: TagViewModelOutput { get }
}

extension TagViewModelType where Self: TagViewModelInput & TagViewModelOutput {
    var input: TagViewModelInput { return self }
    var output: TagViewModelOutput { return self }
}
