//
//  ViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let vc1 = UINavigationController(rootViewController: HomeViewController())
    let vc2 = UINavigationController(rootViewController: SearchViewController())
    let vc3 = UINavigationController(rootViewController: NotificationsViewController())
    let vc4 = UINavigationController(rootViewController: DirectMessagesViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    

    
    private func setup(){
        
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        vc3.tabBarItem.image = UIImage(systemName: "bell")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        vc4.tabBarItem.image = UIImage(systemName: "envelope")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }
}

