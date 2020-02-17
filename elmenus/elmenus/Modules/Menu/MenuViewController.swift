//
//  MenuViewController.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, BindableType {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    // MARK: - Properties
    var viewModel: MenuViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifTableView()
        configureCollectionView()
    }
    
    func bindViewModel() {
    }
    
    private func congifTableView() {
        let itemNib = UINib(nibName: ItemCell.typeName, bundle: nil)
        tableView.register(itemNib, forCellReuseIdentifier: ItemCell.typeName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
    }
    
    private func registerCell() {
        let tagCellNib = UINib(nibName: TagCell.typeName, bundle: nil)
        collectionView.register(tagCellNib, forCellWithReuseIdentifier: TagCell.typeName)
    }

    private func configureCollectionView() {
        registerCell()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let itemWidth = collectionView.bounds.width/2 - 20
        let itemHeight = collectionView.bounds.height
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }

}
