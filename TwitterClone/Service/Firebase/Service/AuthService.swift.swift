//
//  AuthService.swift.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 8.11.2022.
//

import Foundation
import FirebaseAuth
import ProgressHUD


class AuthService {
    
    let auth = Auth.auth()
    
    static let shared = AuthService()
    init(){}
    
    func signIn(email:String,password:String,completion:@escaping(Bool)->Void){
    
            auth.signIn(withEmail: email, password: password) { data, error in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    completion(false)
    
                }else {
                    
                    completion(true)
                }
            }
        }
    
    
    func signUp(email:String,password:String,completion:@escaping(Bool) -> Void){
        
        auth.createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                completion(false)
                
            }else {
                completion(true)
            }
            
        }
    }
    
    func logOut(completion:(Bool)->Void){
           do {
               try auth.signOut()
               completion(true)
           }catch{
               completion(false)
               ProgressHUD.showError(error.localizedDescription)
           }
       }
    
}
