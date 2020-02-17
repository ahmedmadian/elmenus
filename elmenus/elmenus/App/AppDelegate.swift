//
//  AppDelegate.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let router = AppStartupCoordinator().strongRouter

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        router.setRoot(for: window!)
        return true
    }
}

