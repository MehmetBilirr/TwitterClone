//
//  SetupProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import UIKit
import ProgressHUD


class SetupProfileViewModel {
    
    
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
    

    
     func getImageUrl(imageView:UIImageView,completion:@escaping(String)->Void){
        
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
    
    





