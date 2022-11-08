//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase

protocol profileViewModelProtocol:AnyObject {
    func didLogOut()
}

class ProfileViewModel {
    weak var delegate:profileViewModelProtocol?
    
    
    func logOut(){
           
        
        AuthService.shared.logOut { bool in
            if bool {
                delegate?.didLogOut()
            }
        }
        
       }
    
    
}
