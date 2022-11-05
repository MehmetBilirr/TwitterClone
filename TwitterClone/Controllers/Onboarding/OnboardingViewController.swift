//
//  OnboardingViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 3.11.2022.
//

import UIKit
import SnapKit
class OnboardingViewController: UIViewController {
    private let label = UILabel()
    private let signUpButton = UIButton()
    private let hadAccountLbl = UILabel()
    private let loginButton = UIButton()
    let registerVC = RegisterViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
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
        label.text = "See what's happening in the world right now."
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Create account", for: .normal)
        signUpButton.layer.cornerRadius = 20
        signUpButton.clipsToBounds = true
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        
        hadAccountLbl.translatesAutoresizingMaskIntoConstraints = false
        hadAccountLbl.textAlignment = .left
        hadAccountLbl.font = .systemFont(ofSize: 18, weight: .regular)
        hadAccountLbl.textColor = .secondaryLabel
        hadAccountLbl.numberOfLines = 0
        hadAccountLbl.lineBreakMode = .byWordWrapping
        hadAccountLbl.text = "Have an account already?"
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemBlue, for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        
        
    }
    
    private func layout(){
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(300)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(label.snp.bottom).offset(100)
            make.height.equalTo(50)
        }
        
        view.addSubview(hadAccountLbl)
        hadAccountLbl.snp.makeConstraints { make in
            make.left.equalTo(label.snp.left)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.left.equalTo(hadAccountLbl.snp.right).offset(2)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    

}

extension OnboardingViewController {
    
    @objc func didTapSignUp(_ sender:UIButton) {
        print("didtapSignUp")
        
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func didTapLogin(_ sender:UIButton) {
        print("login tapped")
    }
}
