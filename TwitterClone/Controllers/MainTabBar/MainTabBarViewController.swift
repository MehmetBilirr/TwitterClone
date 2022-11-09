//
//  ViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let vc1 = HomeViewController()
    let vc2 = SearchViewController()
    let vc3 = NotificationsViewController()
    let vc4 = DirectMessagesViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    

    
    private func setup(){
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)
        let nc4 = UINavigationController(rootViewController: vc4)
        
        nc1.tabBarItem.image = UIImage(systemName: "house")
        nc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        nc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        nc3.tabBarItem.image = UIImage(systemName: "bell")
        nc3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        nc4.tabBarItem.image = UIImage(systemName: "envelope")
        nc4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        setViewControllers([nc1,nc2,nc3,nc4], animated: true)
    }
}

