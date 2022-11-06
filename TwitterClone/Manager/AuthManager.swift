//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import Foundation
import Firebase
import ProgressHUD


class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    func signUp(email:String,password:String,viewController:RegisterViewController){
        
        Auth.auth().createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                print(error?.localizedDescription)
                
            }else {
                viewController.delegate?.didSignUp()
            }
            
        }
    }
    
    func logOut(viewController:ProfileViewController){
        do {
            try Auth.auth().signOut()
            ProfileViewController.delegate?.didLogOut()
        }catch{
            ProgressHUD.showError(error.localizedDescription)
        }
    }
    
    
    func signIn(email:String,password:String,viewController:LoginViewController){
        
        Auth.auth().signIn(withEmail: email, password: password) { data, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                
            }else {
                guard let user = data?.user else {return}
                viewController.delegate?.didLogin()
            }
        }
    }
    
    
    
}
