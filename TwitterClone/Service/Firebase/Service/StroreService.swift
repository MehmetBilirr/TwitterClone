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


class StoreService{
    
    static let shared = StoreService()
    init(){}
    
    
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
