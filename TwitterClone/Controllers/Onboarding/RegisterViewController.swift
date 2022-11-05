//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    private let label = UILabel()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let signUpButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        style()
        layout()
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
        emailTxtFld.textColor = .gray
        
        
        passwordTxtFld.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtFld.placeholder = "Password"
        passwordTxtFld.textColor = .gray
        passwordTxtFld.isSecureTextEntry = true
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Create account", for: .normal)
        signUpButton.layer.cornerRadius = 20
        signUpButton.clipsToBounds = true
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .systemBlue
        
        
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
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(200)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTxtFld.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
    }
    

   

}