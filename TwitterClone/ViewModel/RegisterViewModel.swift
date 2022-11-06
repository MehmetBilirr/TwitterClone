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
        
        Auth.auth().createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                completion(false)
                
            }else {
                completion(true)
            }
            
        }
    }
    


    
    
    
}
