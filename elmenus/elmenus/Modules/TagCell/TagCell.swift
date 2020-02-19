//
//  TagCell.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class TagCell: UICollectionViewCell, BindableType {
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: TagViewModelType!
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        configCellAppearnce()
    }
    
    func bindViewModel() {
        
        viewModel.output.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.imageURL.subscribe(onNext: { imageURL in
            self.imageView.kf.setImage(with: URL.init(string:  imageURL ), options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage,
            ])
        }).disposed(by: disposeBag)
        
        viewModel.output.isBorderHidden
            .bind(to: borderView.rx.isHidden)
            .disposed(by: disposeBag)
        
    }

    // MARK: - Methods
    private func configCellAppearnce() {
        containerView.makeRoundedCorners(with: containerView.frame.height / 8)
        borderView.makeRoundedCorners(with: borderView.frame.height/8)
        innerView.makeRoundedCorners(with: borderView.frame.height/8)
        imageView.makeRoundedCorners(with: imageView.frame.height / 8)
        animateCell()
    }
    
    private func animateCell() {
           let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
           self.layer.transform = rotationTransform
           self.alpha = 0.5
           UIView.animate(withDuration: 1.0) {
               self.layer.transform = CATransform3DIdentity
               self.alpha = 1.0
           }
       }
}
