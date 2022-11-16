//
//  AppDelegate.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    let mainTabBarVC = MainTabBarViewController()
    let onboardingVC = OnboardingViewController()
    let registerVC = RegisterViewController()
    let loginVC = LoginViewController()
    let profileVC = ProfileViewController()
    let setupProfileVC = SetupProfileViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        ProfileViewController.delegate = self
        onboardingVC.viewModel.delegate = self
        registerVC.viewModel.delegate = self
        loginVC.viewModel.delegate = self
        setupProfileVC.delegate = self
        setRootVC()
        
        return true
    }
    
    
    func setRootVC() {
        
        if Auth.auth().currentUser == nil {
            let navOnboarding = UINavigationController(rootViewController: onboardingVC)
            window?.rootViewController = navOnboarding
        }else if Auth.auth().currentUser != nil && !UserDefaults.standard.hasOnSetup {
            window?.rootViewController = setupProfileVC
        }
        else {
            
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
  

extension AppDelegate:OnboardingToAppDelegate {
    func didTapSignUp(navigationController: UINavigationController) {
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    func didTapLogin(navigationController: UINavigationController) {
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    
}



extension AppDelegate:RegisterToAppDelegate {
    func didSignUp() {
        UserDefaults.standard.hasOnSetup = false
        if !UserDefaults.standard.hasOnSetup {
            window?.rootViewController = setupProfileVC
        }
        
        
    }
    
    
}

extension AppDelegate:LoginToAppDelegate {
    func didLogin() {
        
        if UserDefaults.standard.hasOnSetup {
                mainTabBarVC.vc1.viewModel.fetchUser()
                self.window?.rootViewController = self.mainTabBarVC
            
        }else {
            window?.rootViewController = self.setupProfileVC
        }
        
        
    }
    
    
}


extension AppDelegate:ProfileViewControllerPorotocol {
    func didLogOut() {
        let navOnboarding = UINavigationController(rootViewController: onboardingVC)
        setRootViewController(navOnboarding)
    }
    
    
}

extension AppDelegate:SetupProfileViewControllerProtocol {
    func didFinishSetup() {
        ProgressHUD.show()
            mainTabBarVC.vc1.viewModel.fetchUser()
            self.window?.rootViewController = self.mainTabBarVC
            UserDefaults.standard.hasOnSetup = true
            ProgressHUD.dismiss()
        
        
    }
    
    
    
}
