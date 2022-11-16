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
    var profileVC = ProfileViewController()
    let setupProfileVC = SetupProfileViewController()
    var navOnboarding : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        ProfileViewModel.delegate = self
        onboardingVC.viewModel.delegate = self
        registerVC.viewModel.delegate = self
        loginVC.viewModel.delegate = self
        setupProfileVC.viewModel.delegate = self
        mainTabBarVC.homeVC.viewModel.delegate = self
        mainTabBarVC.searchVC.viewModel.delegate = self
        setRootVC()
        
        return true
    }
    
    
    private func setRootVC() {
        
        if Auth.auth().currentUser == nil {
            navOnboarding = UINavigationController(rootViewController: onboardingVC)
            window?.rootViewController = navOnboarding
        }else if Auth.auth().currentUser != nil && !UserDefaults.standard.hasOnSetup {
            window?.rootViewController = setupProfileVC
        }
        else {
            
            window?.rootViewController = mainTabBarVC
        }
        
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
                mainTabBarVC.homeVC.viewModel.fetchUser()
                self.window?.rootViewController = self.mainTabBarVC
            
        }else {
            window?.rootViewController = self.setupProfileVC
        }
        
        
    }
    
}


extension AppDelegate:SetupToAppDelegate {
    func didFinishSetup() {
        ProgressHUD.show()
            mainTabBarVC.homeVC.viewModel.fetchUser()
            self.window?.rootViewController = self.mainTabBarVC
            UserDefaults.standard.hasOnSetup = true
            ProgressHUD.dismiss()
    }
    
}

extension AppDelegate:PushToProfileDelegate {
    func pushToProfileView(profileViewController: ProfileViewController, navigationController: UINavigationController) {
        profileVC = profileViewController
        navigationController.pushViewController(profileVC, animated: true)
    }
    
}

extension AppDelegate:ProfileToAppDelegate {
    func didLogOut() {
       
        window?.rootViewController = navOnboarding
    }
    
    
}


