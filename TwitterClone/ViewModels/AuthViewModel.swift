//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import Foundation
import Firebase
import ProgressHUD


class AuthViewModel {
    
    func signUp(email:String,password:String){
        
        Auth.auth().createUser(withEmail: email, password: password) { data, error in
            ProgressHUD.showError(error?.localizedDescription)
        }
    }
    
    func logOut(){
        try? Auth.auth().signOut()
    }
    
}
