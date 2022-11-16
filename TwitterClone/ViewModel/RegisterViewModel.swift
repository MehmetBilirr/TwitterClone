//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import Foundation
import Firebase
import ProgressHUD

protocol RegisterViewModelInterface:AnyObject {
    var view:RegisterViewInterface? {get set}
    var delegate:RegisterToAppDelegate? {get set}
    func viewDidLoad()
    func signUp(email:String,password:String)
}

protocol RegisterToAppDelegate:AnyObject{
    func didSignUp()
}

final class RegisterViewModel {
    weak var view:RegisterViewInterface?
    weak var delegate:RegisterToAppDelegate?
    private let authService = AuthService()
    
}

extension RegisterViewModel:RegisterViewModelInterface {
  
    
    func signUp(email: String, password: String) {
        
        authService.signUp(email: email, password: password) { [weak self] bool in
            if bool {
                self?.view?.didSignUp()
                self?.delegate?.didSignUp()
            }
        }
    }

    func viewDidLoad() {
        view?.style()
        view?.layout()
        
    }
    

    
}
