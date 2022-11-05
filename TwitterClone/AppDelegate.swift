//
//  AppDelegate.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let mainTabBarVC = MainTabBarViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        setRootVC()
        
        return true
    }
    
    
    func setRootVC() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if Auth.auth().currentUser == nil {
            let navigationContoller = UINavigationController(rootViewController: OnboardingViewController())
            window?.rootViewController = navigationContoller
        }else {
            let navigationContoller = UINavigationController(rootViewController: OnboardingViewController())
            window?.rootViewController = navigationContoller
        }
    }
  
  


}

