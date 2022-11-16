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

protocol SetupProfileViewModelInterface:AnyObject {
    
    var view:SetupProfileViewInterface? {get set}
    
    func viewDidLoad()
    func setupProfile(imageView:UIImageView,userName:String,fullName:String)
    func didTapImage()
}

class SetupProfileViewModel {
    weak var view: SetupProfileViewInterface?
    let userService = UserService()
        
}
    

extension SetupProfileViewModel:SetupProfileViewModelInterface {
    
    func setupProfile(imageView: UIImageView, userName: String, fullName: String) {
        userService.setupProfile(imageView: imageView, userName: userName, fullName: fullName) { [weak self] bool in
            if bool {
                self?.view?.didSetupProfile()
            }
        }
    }
    
    
    func viewDidLoad() {
        view?.style()
        view?.layout()
    }
    
    func didTapImage() {
        view?.didtapImage()
    }
    
    
}
    





