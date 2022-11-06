//
//  LoginViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase


class LoginViewModel {
    
    
    func signIn(email:String,password:String,completion:@escaping(Bool)->Void){
    
            Auth.auth().signIn(withEmail: email, password: password) { data, error in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    completion(false)
    
                }else {
                    
                    completion(true)
                }
            }
        }
}
