//
//  ItemDetailViewController.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class ItemDetailViewController: UIViewController, BindableType {
    
    //MARK :- Outlet
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: ItemDetailViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }
   
    func test() {
        //var value = 0
       let tagRepo = TagRepository(localService: TagLocalService(context: CoreDataManager.shared.managedContext))
        let res = tagRepo.getTagsfromLocal()
        print(res)
        _ = res.subscribe(onNext: {
            print($0)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        backButton.rx.tap
        .bind(to: viewModel.input.back)
        .disposed(by: disposeBag)
        
        viewModel.output.itemData
            .subscribe(onNext: { (item) in self.fillDetails(with: item) })
            .disposed(by: disposeBag)
    }
    
    private func fillDetails(with viewModel: ItemViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        headeImageView.kf.setImage(with: URL.init(string: viewModel.imageURL ), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
    }
}

//MARK: ScrollView Delegate
extension ItemDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 300 {
            imageViewHeightConstraint.constant = 60
        }
        
        let valu = 300 - scrollView.contentOffset.y
        if valu >= 60 {
            imageViewHeightConstraint.constant = valu
        }
    }
}
