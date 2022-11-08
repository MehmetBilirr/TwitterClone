//
//  HomeViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import ProgressHUD

protocol HomeViewModelProtocol:AnyObject {
    func getTweets(tweets:[Tweet])
    func getUser(user:User)
}

class HomeViewModel {
    weak var delegate:HomeViewModelProtocol?
    let userService = UserService()
    let tweetService = TweetService()
    func fetchUser(){
        
        guard let uuid = Auth.auth().currentUser?.uid else {return}
        userService.fetchUser(uuid: uuid) { User in
            self.delegate?.getUser(user: User)
            
        }
    
        
    }
    
    func fetchTweets(){
        tweetService.fetchAllData { tweets in
            self.delegate?.getTweets(tweets: tweets)
            
        }
        
    }
    
    func fetchCurrentUserTweet(viewController:ProfileViewController){
        guard let user = Auth.auth().currentUser else {return}
        tweetService.fetchUserData(uuid: user.uid) { tweets in
            viewController.tweetArray = tweets
            viewController.profileTableView.reloadData()
        
        }
    }
    
    func fetchChosenUserTweet(uuid:String,viewController:ProfileViewController) {
        
        tweetService.fetchUserData(uuid: uuid) { tweets in
            viewController.tweetArray = tweets
            viewController.profileTableView.reloadData()
        }
    }
    
}
