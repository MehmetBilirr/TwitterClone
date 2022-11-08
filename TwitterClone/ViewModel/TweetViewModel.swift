//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 9.11.2022.
//

import Foundation
import FirebaseAuth
protocol TweetViewModelProtocol:AnyObject {
    func getImageUrl(url:String)
}

class TweetViewModel {
    
    let userService = UserService()
    let tweetService = TweetService()
    weak var delegate:TweetViewModelProtocol?
    func fetchUserImage(){
        
        guard let uuid = Auth.auth().currentUser?.uid else {return}
        userService.fetchUser(uuid: uuid) { User in
            self.delegate?.getImageUrl(url: User.imageUrl)
            
        }
    }
    
    
    
    
}
