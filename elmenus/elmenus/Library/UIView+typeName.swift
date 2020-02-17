//
//  UIView+typeName.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

extension UIView {
    static var typeName: String {
        return String(describing: self)
    }
    
    func makeRoundedCorners(with avg: CGFloat) {
        layer.cornerRadius = self.frame.height / avg
    }
}
