//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import UIKit
import Firebase
import ProgressHUD

protocol LoginViewControllerProcotol:AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    private let label = UILabel()
    private let emailTxtFld = UITextField()
    private let passwordTxtFld = UITextField()
    private let registerButton = UIButton()
    weak var delegate:LoginViewControllerProcotol?
    private let forgotLbl = UILabel()
    let loginVM = LoginViewModel()
    
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
        label.text = "Login to your Account"
        
        emailTxtFld.translatesAutoresizingMaskIntoConstraints = false
        emailTxtFld.placeholder = "Email"
        emailTxtFld.textColor = .black
        
        
        
        passwordTxtFld.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtFld.placeholder = "Password"
        passwordTxtFld.textColor = .black
        passwordTxtFld.isSecureTextEntry = true
        passwordTxtFld.enablePasswordToggle()
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Login", for: .normal)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        
        
        forgotLbl.translatesAutoresizingMaskIntoConstraints = false
        forgotLbl.textAlignment = .center
        forgotLbl.font = .systemFont(ofSize: 18, weight: .regular)
        forgotLbl.textColor = .black
        forgotLbl.numberOfLines = 0
        forgotLbl.lineBreakMode = .byWordWrapping
        let attributedString  = NSMutableAttributedString(string: "Forgot password?", attributes: [NSAttributedString.Key.underlineStyle : true])
        forgotLbl.attributedText = attributedString
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
        
        view.addSubview(forgotLbl)
        forgotLbl.snp.makeConstraints { make in
            make.left.equalTo(registerButton.snp.left)
            make.right.equalTo(registerButton.snp.right)
            make.top.equalTo(registerButton.snp.bottom).offset(10)
        }
    }
    
    
    
}

// methods
extension LoginViewController {
    
    @objc func didTapToDismiss(){
        view.endEditing(true)
    }
   
    @objc func didTapLogin(_ sender : UIButton){
        guard let mail = emailTxtFld.text, let pass = passwordTxtFld.text else {return}
        loginVM.signIn(email: mail, password: pass) { success in
            if success {
                self.delegate?.didLogin()
                self.emailTxtFld.text = ""
                self.passwordTxtFld.text = ""
            }
        }
        
        
        
    }
    
}
