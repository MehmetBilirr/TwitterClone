//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import UIKit
import SnapKit
import Firebase
import ProgressHUD

protocol RegisterViewControllerProtocol:AnyObject {
    func didSignUp()
}
class RegisterViewController: UIViewController {
    private let label = UILabel()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let registerButton = UIButton()
    weak var delegate: RegisterViewControllerProtocol?
    private let registerVM = RegisterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        style()
        layout()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
    }
    
    
    private func style(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Create your Account"
        
        emailTxtFld.translatesAutoresizingMaskIntoConstraints = false
        emailTxtFld.placeholder = "Email"
        emailTxtFld.textColor = .black
        
        
        
        passwordTxtFld.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtFld.placeholder = "Password"
        passwordTxtFld.textColor = .black
        passwordTxtFld.isSecureTextEntry = true
        passwordTxtFld.enablePasswordToggle()
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Create account", for: .normal)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        
        
    }
    
    private func layout(){
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(150)
        }
        
        view.addSubview(emailTxtFld)
        
        emailTxtFld.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(label.snp.bottom).offset(50)
        }
        
        view.addSubview(passwordTxtFld)
        passwordTxtFld.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(emailTxtFld.snp.bottom).offset(20)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(200)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTxtFld.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
    }
    
    @objc func didTapToDismiss(){
        view.endEditing(true)
    }
   
    @objc func didTapRegister(){
        guard let mail = emailTxtFld.text, let pass = passwordTxtFld.text else {return}
        
        registerVM.signUp(email: mail, password: pass) { success in
            
            if success {
                self.delegate?.didSignUp()
            }
        }
        
        
    }
    
}

