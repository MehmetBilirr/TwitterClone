//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase

protocol ProfileViewModelProtocol:AnyObject {
    func didLogOut()
}

class ProfileViewModel {
    weak var delegate:ProfileViewModelProtocol?
    
    
    func logOut(){
           
        
        AuthService.shared.logOut { bool in
            if bool {
                delegate?.didLogOut()
            }
        }
        
       }
    
    
}
