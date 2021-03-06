//
//  MenuViewController.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MenuViewController: BaseViewController, BindableType {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var lastSelectedIndex: IndexPath?

    // MARK: - Dependencies
    var viewModel: MenuViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        congifTableView()
        configureCollectionView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Method
    func bindViewModel() {
        
        //Inputs
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .map { _ in }
            .bind(to: viewModel.input.viewLoaded)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {
            self.lastSelectedIndex = $0
        }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ItemViewModel.self)
            .bind(to: viewModel.input.selectedItem)
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TagViewModel.self)
            .do(onNext: { (viewModel) in
                viewModel.isBorderHidden.accept(false)
            })
            .bind(to: viewModel.input.selectedTag)
            .disposed(by: disposeBag)
        
        collectionView.rx.modelDeselected(TagViewModel.self)
            .subscribe(onNext :{ (viewModel) in
                viewModel.isBorderHidden.accept(true)
            }).disposed(by: disposeBag)
        
        collectionView.rx.didScroll.subscribe(onNext: {
            let offsetX = self.collectionView.contentOffset.x
            let contentWidth = self.collectionView.contentSize.width
            if offsetX > contentWidth - self.collectionView.frame.width{
                self.viewModel.input.loadNextTags.onNext(())
            }
        }).disposed(by: disposeBag)
        
        // Outputs
        viewModel.output.errorMessage
            .subscribe(onNext: {
                self.showErrorMessage(text: $0)
            }).disposed(by: disposeBag)
        
        viewModel.output.itemsData
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: ItemCell.typeName, cellType: ItemCell.self)) { item, data, itemCell in
                itemCell.configCellAppearnce(with: data)
        }.disposed(by: disposeBag)
        
        viewModel.output.tagsData
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: TagCell.typeName, cellType: TagCell.self)) { item, viewModel, cell in
                cell.bind(to: viewModel)
        }.disposed(by: disposeBag)
        
        viewModel.output.loading.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    
    private func congifTableView() {
        let itemNib = UINib(nibName: ItemCell.typeName, bundle: nil)
        tableView.register(itemNib, forCellReuseIdentifier: ItemCell.typeName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    private func registerCell() {
        let tagCellNib = UINib(nibName: TagCell.typeName, bundle: nil)
        collectionView.register(tagCellNib, forCellWithReuseIdentifier: TagCell.typeName)
    }
    
    private func configureCollectionView() {
        registerCell()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let itemWidth = collectionView.bounds.width/4
        let itemHeight = collectionView.bounds.height
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
}


extension MenuViewController: NTTransitionHomeViewProtocol {
    func transitionTableView() -> UITableView {
        return self.tableView
    }
    
    func latestSelectedIndex() -> IndexPath {
        if let indexPath = self.lastSelectedIndex { return indexPath}
        return IndexPath()
    }
    
    
}
