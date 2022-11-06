//
//  UserService.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class UserService {
    
    static let shared = UserService()
    init(){}
    
    
    func fetchUser(uuid:String,completion:@escaping (User)->Void){
        
        Firestore.firestore().collection("users").document(uuid).getDocument { snapshot, error in
            guard let snaphot = snapshot else {return}
            
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
    }
    
    func fetchUsers(completion:@escaping ([User])->Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else {return}
            documents.forEach { document in
                guard let user = try? document.data(as: User.self) else {return}
                
                users.append(user)
            }
            completion(users)
            
        }
        
        
    }
    
     
}
