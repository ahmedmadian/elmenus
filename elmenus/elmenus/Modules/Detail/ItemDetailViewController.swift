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
    
    // MARK: - Outlet
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: ItemDetailViewModelType!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    // MARK: - Methods
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
        var lastContentOffset: CGFloat = 60.0
        let maxHeaderHeight: CGFloat = 300.0
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //Scrolled to bottom
            UIView.animate(withDuration: 0.3) {
                self.imageViewHeightConstraint.constant = 60
                self.view.layoutIfNeeded()
            }
        }
        else if (scrollView.contentOffset.y < lastContentOffset || scrollView.contentOffset.y <= 60) && (self.imageViewHeightConstraint.constant != maxHeaderHeight)  {
            //Scrolling up, scrolled to top
            UIView.animate(withDuration: 0.3) {
                self.imageViewHeightConstraint.constant = maxHeaderHeight
                self.view.layoutIfNeeded()
            }
        }
        else if (scrollView.contentOffset.y > lastContentOffset) && self.imageViewHeightConstraint.constant != 60 {
            //Scrolling down
            UIView.animate(withDuration: 0.3) {
                self.imageViewHeightConstraint.constant = 60
                self.view.layoutIfNeeded()
            }
        }
        lastContentOffset = scrollView.contentOffset.y
    }
}
