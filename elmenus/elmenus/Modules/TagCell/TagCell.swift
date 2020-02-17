//
//  TagCell.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import Kingfisher

class TagCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Methods
    func configCellAppearnce(with viewModel: TagViewModel) {
        imageView.kf.setImage(with: URL.init(string: viewModel.imageURL ), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        containerView.makeRoundedCorners(with: containerView.frame.height / 8)
        borderView.makeRoundedCorners(with: borderView.frame.height/8)
        imageView.makeRoundedCorners(with: imageView.frame.height / 8)
        titleLabel.text = viewModel.title
    }
}
