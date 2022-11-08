//
//  UserService.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseStorage
import UIKit

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
    
    func setupProfile(imageView:UIImageView,userName:String,fullName:String){
        
        
        getImageUrl(imageView: imageView) { imageUrl in
            print(imageUrl)
            self.createDataFirestore(imageUrl: imageUrl, userName: userName, fullName: fullName)
            
            
        }
        
    }
    
    private func createDataFirestore(imageUrl:String,userName:String,fullName:String){
        
        guard let user = Auth.auth().currentUser else {return}
        
        
        let data = [
                    "username":userName,
                    "fullname":fullName,
                    "imageUrl":imageUrl,
                    "uid":user.uid,
                    ] as [String : Any]
        
        Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
            
            guard let error = error else {
                print(error?.localizedDescription)
                return
            }
            
        }
        
    }
    

    
     private func getImageUrl(imageView:UIImageView,completion:@escaping(String)->Void){
        
        guard let data = imageView.image?.jpegData(compressionQuality: 0.5) else {return }
        let uuid = UUID().uuidString
        
        let ref = Storage.storage().reference().child("media").child("\(uuid).jpg")
        ref.putData(data) { metada, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                ref.downloadURL { imageUrl, error in
                    
                    guard let imageUrl = imageUrl?.absoluteString else{return}
                        completion(imageUrl)
                       
                        
                    }
                    
                }
            }
            
        }
    
     
}
