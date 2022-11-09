//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import Foundation
protocol SearchViewModelProtocol:AnyObject{
    func getUsers(users:[User])
}

class SearchViewModel {
    let userService = UserService()
    weak var delegate:SearchViewModelProtocol?
    let tweetService = TweetService()
    
    func fetchUsers(){
        
        userService.fetchUsers {  userArray in
            self.delegate?.getUsers(users: userArray)
            
        }
        
        }
        
        func fetchChoosenUserTweet(uuid:String,viewController:ProfileViewController) {
            
            tweetService.fetchUserData(uuid: uuid) { tweets in
                viewController.tweetArray = tweets
                viewController.profileTableView.reloadData()
            }
        }
        
    
}
