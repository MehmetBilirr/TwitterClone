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
    let onboardingVC = OnboardingViewController()
    let registerVC = RegisterViewController()
    let profileVC = ProfileViewController()
    let setupProfileVC = SetupProfileViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        onboardingVC.registerVC.delegate = self
        ProfileViewController.delegate = self
        onboardingVC.loginVC.delegate = self
        setRootVC()
        
        
        return true
    }
    
    
    func setRootVC() {
        
        if Auth.auth().currentUser == nil {
            let navOnboarding = UINavigationController(rootViewController: onboardingVC)
            window?.rootViewController = setupProfileVC
        }else {
            
            window?.rootViewController = mainTabBarVC
        }
        
    }
    
    func setRootViewController(_ vc:UIViewController,animated:Bool = true) {
        
        guard animated,let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
        
    }
  




extension AppDelegate:RegisterViewControllerProtocol {
    func didSignUp() {
        window?.rootViewController = setupProfileVC
        
    }
    
    
}

extension AppDelegate:ProfileViewControllerPorotocol {
    func didLogOut() {
        mainTabBarVC.selectedIndex = 0
        let navOnboarding = UINavigationController(rootViewController: onboardingVC)
        setRootViewController(navOnboarding)
    }
    
    
}


extension AppDelegate:LoginViewControllerProcotol {
    func didLogin() {

        window?.rootViewController = mainTabBarVC
    }
    
    
}
