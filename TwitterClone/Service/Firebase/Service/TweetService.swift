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

// Likes
extension TweetService {
    
    func likeTweet (tweet: Tweet,completion:@escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes":tweet.likes + 1]) { _ in
            
            userLikesRef.document(tweetId).setData([:]) { _ in
                completion(true)
            }
        }
        
    }
    
    func checkIfUserLikedTweet(tweet:Tweet,completion:@escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes").document(tweetId).getDocument { snapshot, error in
            guard let snapshot = snapshot else {return}
            completion(snapshot.exists)
        }
        
    }
    
    func unlikeTweet(tweet:Tweet,completion:@escaping()->Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        guard tweet.likes > 0 else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes":tweet.likes - 1]) { _ in
            
            userLikesRef.document(tweetId).delete { _ in
                completion()
            }
        }
    }
    
    func fetchLikedTweets(uid:String,completion:@escaping([Tweet])->Void) {
        
        var tweetArray = [Tweet]()
        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else {return}
                documents.forEach { doc in
                    let tweetId = doc.documentID
                    
                    Firestore.firestore().collection("tweets").document(tweetId).getDocument { snapshot, _ in
                        
                        guard let tweet = try? snapshot?.data(as: Tweet.self) else {return}
                        
                        tweetArray.append(tweet)
                        
                        for i in 0..<tweetArray.count {
                            guard let uid = tweetArray[i].uid else {return}
                            self.userService.fetchUser(uuid: uid) { User in
                                tweetArray[i].user = User
                                print(tweetArray)
                                completion(tweetArray.sorted(by: {$0.timestamp > $1.timestamp}))
                            }
                        }
                    }
            }
            
            
            
           
            
        }
        
        
        
    }
}


