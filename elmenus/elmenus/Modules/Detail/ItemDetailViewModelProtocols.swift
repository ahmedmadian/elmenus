//
//  ItemDetailViewModelProtocols.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ItemDetailViewModelInput {
    var loaded: PublishSubject<Void> { get }
    var back: PublishSubject<Void> { get }
}

protocol ItemDetailViewModelOutput {
    var itemData: BehaviorRelay<ItemViewModel> { get }
}

protocol ItemDetailViewModelType {
    var input: ItemDetailViewModelInput { get }
    var output: ItemDetailViewModelOutput { get }
}

extension ItemDetailViewModelType where Self: ItemDetailViewModelInput & ItemDetailViewModelOutput {
    var input: ItemDetailViewModelInput { return self }
    var output: ItemDetailViewModelOutput { return self }
}
