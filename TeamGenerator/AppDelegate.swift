//
//  AppDelegate.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 06/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        FIRApp.configure()
        
        let tabBarController = UITabBarController()
        let playerListViewController = PlayerListViewController(nibName: "PlayerListViewController", bundle: nil)
        playerListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        playerListViewController.viewModel = PlayerListViewModelFromPlayers()
        
//        let classificationViewController = ClassificationViewController(nibName: "ClassificationViewController", bundle: nil)
//        classificationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//
//        let gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
//        gameViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
//
        tabBarController.viewControllers = [playerListViewController]//, classificationViewController, gameViewController]
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}

