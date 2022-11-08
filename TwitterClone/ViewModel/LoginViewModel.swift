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
    
        AuthService.shared.signIn(email: email, password: password, completion: completion)
        }
}
