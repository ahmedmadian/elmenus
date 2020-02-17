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
    
    
    // MARK: - Methods
    func configCellAppearnce(with viewModel: ItemViewModel) {
        itemImageView.kf.setImage(with: URL.init(string: viewModel.imageURL ), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        titlLabel.text = viewModel.name
    }
    
}
