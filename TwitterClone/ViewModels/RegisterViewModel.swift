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
    
    
    func signUp(email:String,password:String) {
        
        
        let auth = Auth.auth()
        
        auth.createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            }
            
            
        }
    }
    
    
    
}
