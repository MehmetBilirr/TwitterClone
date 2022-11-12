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
    
    
    func fetchUserData(uid:String,viewController:ProfileViewController) {
        
        tweetService.fetchUserData(uuid: uid) { tweets in
            viewController.tweetArray = tweets
            viewController.profileTableView.reloadData()
        }
    }
    
    
    func fetchLikeTweets(uid:String,viewController:ProfileViewController) {
        
        tweetService.fetchLikedTweets(uid: uid) { tweets in
            viewController.tweetArray = tweets
            viewController.profileTableView.reloadData()
        }
        
        
        
    }
    
}
