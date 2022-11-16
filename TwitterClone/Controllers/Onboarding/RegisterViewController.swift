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


protocol RegisterViewInterface:AnyObject {
    func style()
    func layout()
    func didSignUp()
    
}
class RegisterViewController: UIViewController {
    private let label = UILabel()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let registerButton = UIButton()
    let viewModel = RegisterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}


extension RegisterViewController:RegisterViewInterface {
    
    func style() {
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        label.configureStyle(size: 35, weight: .bold, color: .black)
        label.text = "Create your Account"
        
        emailTxtFld.configureStyle(placeHolder: "Email", txtColor: .black)
        emailTxtFld.textColor = .black
        
        passwordTxtFld.configureStyle(placeHolder: "Password", txtColor: .black)
        passwordTxtFld.isSecureTextEntry = true
        passwordTxtFld.enablePasswordToggle()
        
        registerButton.configureStyle(title: "Create Account", titleColor: .black)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.backgroundColor = .systemBlue
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    func layout() {
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
    
    @objc func didTapRegister(){
        guard let mail = emailTxtFld.text, let pass = passwordTxtFld.text else {return}
        viewModel.signUp(email: mail, password: pass)
    }
    
    func didSignUp() {
        
        self.emailTxtFld.text = ""
        self.passwordTxtFld.text = ""
    }
    
    @objc func didTapToDismiss(){
        view.endEditing(true)
    }
    
}
