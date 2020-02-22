//
//  SharedElementTransitionProtocols.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import UIKit

@objc protocol NTTransitionHomeViewProtocol{
    func transitionTableView() -> UITableView
    func latestSelectedIndex() -> IndexPath
}

@objc protocol NTTransitionPageViewProtocol{
}

@objc protocol NTTansitionSnapShotProvidorProtocol{
    func snapShotForTransition() -> UIView
}
