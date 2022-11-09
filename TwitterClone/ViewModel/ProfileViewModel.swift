//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase
import FirebaseFirestoreSwift

protocol ProfileViewModelProtocol:AnyObject {
    func didLogOut()
}

class ProfileViewModel {
    weak var delegate:ProfileViewModelProtocol?
    let tweetService = TweetService()
    
    
    func logOut(){
           
        
        AuthService.shared.logOut { bool in
            if bool {
                delegate?.didLogOut()
            }
        }
        
       }
    
    
    
    
}
