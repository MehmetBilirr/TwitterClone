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
    let userService = UserService()
    
    func setupProfile(imageView:UIImageView,userName:String,fullName:String){
        
        
        userService.setupProfile(imageView: imageView, userName: userName, fullName: fullName)
        
    }
    
   
        
}
    
    





