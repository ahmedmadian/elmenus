//
//  ItemCell.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCell: UITableViewCell {
    
    // MARK: Outlet
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var labelContainerView: UIView!
    
    
    // MARK: - Methods
    func configCellAppearnce(with viewModel: ItemViewModel) {
        itemImageView.kf.setImage(with: URL.init(string: viewModel.imageURL ), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        itemImageView.makeRoundedCorners(with: itemImageView.frame.height / 8)
        labelContainerView.makeRoundedCorners(with: labelContainerView.frame.height / 8)
        titlLabel.text = viewModel.name
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
