//
//  OnboardingViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 3.11.2022.
//

import UIKit
import SnapKit

protocol OnboardingViewInterface:AnyObject{
    func style()
    func layout()
}
final class OnboardingViewController: UIViewController {
    private let label = UILabel()
    private let signUpButton = UIButton()
    private let hadAccountLbl = UILabel()
    private let loginButton = UIButton()
    let viewModel = OnboardingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.navigationController  = navigationController
        viewModel.viewDidLoad()
        viewModel.navigationController?.viewDidLoad()
       
        
    }


}

extension OnboardingViewController {
    
    @objc func didTapSignUp(_ sender:UIButton) {
        viewModel.didTapSignUp()
    }
    
    @objc func didTapLogin(_ sender:UIButton) {
        viewModel.didTapLogin()
    }
}


extension OnboardingViewController:OnboardingViewInterface {
    func style() {
        view.backgroundColor = .white
        label.configureStyle(size: 35, weight: .bold, color: .black)
        label.text = "See what's happening in the world right now."
        
     
        signUpButton.configureStyle(title: "Create Account", titleColor: .white)
        signUpButton.layer.cornerRadius = 20
        signUpButton.clipsToBounds = true
        signUpButton.backgroundColor = .systemBlue
        signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        
        
        hadAccountLbl.configureStyle(size: 18, weight: .regular, color: .secondaryLabel)
        hadAccountLbl.text = "Have an account already?"
        
        loginButton.configureStyle(title: "Login", titleColor: .systemBlue)
        loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
    }
    
    func layout() {
        
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
