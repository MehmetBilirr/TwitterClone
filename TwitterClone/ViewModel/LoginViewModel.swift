//
//  LoginViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase

protocol LoginToAppDelegate:AnyObject {
    func didLogin()
}

protocol LoginViewModelInterface:AnyObject {
    var view:LoginViewInterface? {get set}
    var delegate:LoginToAppDelegate? {get set}
    func viewDidLoad()
    func signIn(email:String,password:String)
}


final class LoginViewModel {
    let authService = AuthService()
    weak var view:LoginViewInterface?
    weak var delegate: LoginToAppDelegate?
}

extension LoginViewModel:LoginViewModelInterface {
    func signIn(email: String, password: String) {
        
        authService.signIn(email: email, password: password) { [weak self] bool in
            if bool {
                self?.delegate?.didLogin()
                self?.view?.didSignIn()
                
            }
        }
    }
    
    func viewDidLoad() {
        view?.style()
        view?.layout()
    }
    
    
}


