//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import Foundation
import Firebase
import ProgressHUD


class RegisterViewModel {
    
    
    func signUp(email:String,password:String,completion:@escaping(Bool) -> Void){
        
        AuthService.shared.signUp(email: email, password: password, completion: completion)
    }
    


    
    
    
}
