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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        FirebaseApp.configure()
        
        let tabBarController = UITabBarController()
        
        let playerListViewController = PlayerListViewController(nibName: "PlayerListViewController", bundle: nil)
        playerListViewController.viewModel = PlayerListViewModelFromPlayers(playerLibrary: DatabasePlayerLibrary())
        let playerNavigationController = UINavigationController(rootViewController: playerListViewController)
        
        let playerImage = UIImage(named: "player")
        let playerFilledImage = UIImage(named: "player-filled")
        playerNavigationController.tabBarItem = UITabBarItem(title: "Jogadores", image: playerImage, selectedImage: playerFilledImage)
        
        let classificationViewController = ClassificationViewController(nibName: "ClassificationViewController", bundle: nil)
        classificationViewController.viewModel = ClassificationViewModelFromPlayers(playerLibrary: DatabasePlayerLibrary())
        
        let trophyImage = UIImage(named: "trophy")
        let trophyFilledImage = UIImage(named: "trophy-filled")
        classificationViewController.tabBarItem = UITabBarItem(title: "Classificação", image: trophyImage, selectedImage: trophyFilledImage)
        
        let teamsViewController = TeamsViewController(nibName: "TeamsViewController", bundle: nil)
        
        let ballImage = UIImage(named: "ball")
        let ballFilledImage = UIImage(named: "ball-filled")
        teamsViewController.tabBarItem = UITabBarItem(title: "Jogo", image: ballImage, selectedImage: ballFilledImage)

        tabBarController.viewControllers = [playerNavigationController, classificationViewController, teamsViewController]
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}

