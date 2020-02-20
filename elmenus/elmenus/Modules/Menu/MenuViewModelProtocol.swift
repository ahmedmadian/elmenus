//
//  MenuViewModelProtocol.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MenuViewModelInput {
    var viewLoaded: PublishSubject<Void> { get }
    var loadNextTags: PublishSubject<Void> { get }
    var selectedItem: PublishSubject<ItemViewModel> { get }
    var selectedTag: PublishSubject<TagViewModel> { get }
}

protocol MenuViewModelOutput {
    var tagsData: BehaviorRelay<[TagViewModel]> { get }
    var itemsData: BehaviorRelay<[ItemViewModel]> { get }
    var errorMessage: PublishSubject<String> { get }
    var loading: Observable<Bool> { get }
}

protocol MenuViewModelType {
    var input: MenuViewModelInput { get }
    var output: MenuViewModelOutput { get }
}

extension MenuViewModelType where Self: MenuViewModelInput & MenuViewModelOutput {
    var input: MenuViewModelInput { return self }
    var output: MenuViewModelOutput { return self }
}
