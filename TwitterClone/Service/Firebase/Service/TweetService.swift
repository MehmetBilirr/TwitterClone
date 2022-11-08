//
//  StrorageService.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 8.11.2022.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore


class TweetService{
    
    let userService = UserService()
    
    func createData(caption:String){
        
        guard let user = Auth.auth().currentUser else {return}
        
        
        let data = [
                    "uid":user.uid,
                    "caption":caption,
                    "timestamp":Timestamp(date: Date()),
                    "likes":0,
                    ] as [String : Any]
        
        Firestore.firestore().collection("tweets").document().setData(data) { error in
            
            guard let error = error else {
                print(error?.localizedDescription)
                return
            }
            
        }
        
    }
    
    func fetchAllData(completion:@escaping([Tweet])->Void) {
        var tweetArray = [Tweet]()
        Firestore.firestore().collection("tweets").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else {return}
            
            documents.forEach { document in
                guard let tweet = try? document.data(as: Tweet.self) else {return}
                
                tweetArray.append(tweet)
            }
            
            for i in 0..<tweetArray.count {
                
                guard let uid = tweetArray[i].uid else {return}
                 
                self.userService.fetchUser(uuid: uid) { User in
                    tweetArray[i].user = User
                    completion(tweetArray)
                }
                
            }
            
        }
        
    }
    
    func fetchUserData(uuid:String,completion:@escaping([Tweet])->Void) {
        var tweetArray = [Tweet]()
        Firestore.firestore().collection("tweets").whereField("uid", isEqualTo: uuid).getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else {return}
            documents.forEach { document in
                guard let tweet = try? document.data(as: Tweet.self) else {return}
                tweetArray.append(tweet)
            }
            for i in 0..<tweetArray.count {
                guard let uid = tweetArray[i].uid else {return}
                self.userService.fetchUser(uuid: uid) { User in
                    tweetArray[i].user = User
                    completion(tweetArray.sorted(by: {$0.timestamp > $1.timestamp}))
                }
            }
            
            
    }
    
    
  }

}
