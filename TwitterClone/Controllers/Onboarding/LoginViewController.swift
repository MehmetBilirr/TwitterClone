//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import UIKit


protocol LoginViewInterface:AnyObject {
    func style()
    func layout()
    func didSignIn()
}

final class LoginViewController: UIViewController {

    private let label = UILabel()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let registerButton = UIButton()
    private let forgotLbl = UILabel()
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

}


extension LoginViewController:LoginViewInterface {
    func style() {
        view.backgroundColor = .systemBackground
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        label.configureStyle(size: 35, weight: .bold, color: .black)
        label.text = "Login to your Account"
        
        emailTxtFld.configureStyle(placeHolder: "Email", txtColor: .black)
        
        passwordTxtFld.configureStyle(placeHolder: "Password", txtColor: .black)
        passwordTxtFld.isSecureTextEntry = true
        passwordTxtFld.enablePasswordToggle()
        
        registerButton.configureStyle(title: "Login", titleColor: .white)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.backgroundColor = .systemBlue
        registerButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        
        forgotLbl.configureStyle(size: 18, weight: .regular, color: .black)
        forgotLbl.textAlignment = .center
        let attributedString  = NSMutableAttributedString(string: "Forgot password?", attributes: [NSAttributedString.Key.underlineStyle : true])
        forgotLbl.attributedText = attributedString
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
        
        view.addSubview(forgotLbl)
        forgotLbl.snp.makeConstraints { make in
            make.left.equalTo(registerButton.snp.left)
            make.right.equalTo(registerButton.snp.right)
            make.top.equalTo(registerButton.snp.bottom).offset(10)
        }
    
    }
    
    
    @objc func didTapToDismiss(){
        view.endEditing(true)
    }
   
    @objc func didTapLogin(_ sender : UIButton){
        guard let mail = emailTxtFld.text, let pass = passwordTxtFld.text else {return}
        
        viewModel.signIn(email: mail, password: pass)
    }
    
    func didSignIn() {
        emailTxtFld.text = ""
        passwordTxtFld.text = ""
    }
    
}
