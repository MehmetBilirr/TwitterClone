//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase


class ProfileViewModel {
    
    
    
    func logOut(completion:(Bool)->Void){
           
        AuthService.shared.logOut(completion: completion)
       }
    
    
}
