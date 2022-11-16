//
//  SetupProfileViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import UIKit
import SnapKit
import ProgressHUD


protocol SetupProfileViewInterface:AnyObject {
    func style()
    func layout()
    func didSetupProfile()
    func didtapImage()
}


final class SetupProfileViewController: UIViewController {

    private let label = UILabel()
    private let mailTxtFld = UITextField()
    private let userNameTxtFld = UITextField()
    private let fullNameTxtFld = UITextField()
    private let stackView = UIStackView()
    private let betweenView1 = UIView()
    private let betweenView2 = UIView()
    private let imageView = UIImageView()
    private let doneButton = UIButton()
    let viewModel = SetupProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}


extension SetupProfileViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func didTapImage(_ sender:UITapGestureRecognizer) {
        
        viewModel.didTapImage()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func didTapToDismiss(){
        view.endEditing(true)
    }
    
    @objc func didTapDoneButton(_ sender:UIButton){
        guard let username = userNameTxtFld.text,let fullName = fullNameTxtFld.text else {return}
        
        if  userNameTxtFld.text == "" {
            ProgressHUD.showError("Username cannot be empty")
        }else if fullNameTxtFld.text == ""{
            ProgressHUD.showError("Full name cannot be empty")
        }else {
            
            viewModel.setupProfile(imageView: imageView, userName: username, fullName: fullName)
            
        }
 }

}


extension SetupProfileViewController:SetupProfileViewInterface {
    func style() {
        
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        label.configureStyle(size: 38, weight: .bold, color: .black)
        label.text = "Get started.\n Create your profile"
        
        userNameTxtFld.configureStyle(placeHolder: "Username", txtColor: .black)
        
        fullNameTxtFld.configureStyle(placeHolder: "Fullname", txtColor: .black)
        
        stackView.configureStyle(axiS: .vertical, space: 10)
  
        
        betweenView2.translatesAutoresizingMaskIntoConstraints = false
        betweenView2.backgroundColor = .secondarySystemFill
        betweenView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        imageView.configureStyle(contntMode: .scaleAspectFill)
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 100
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        imageView.addGestureRecognizer(tapGesture)

        
        doneButton.configureStyle(title: "Done", titleColor: .white)
        doneButton.layer.cornerRadius = 20
        doneButton.clipsToBounds = true
        doneButton.backgroundColor = .systemBlue
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
    }
    
    func layout() {
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(100)
            }
            
            stackView.addArrangedSubview(userNameTxtFld)
            stackView.addArrangedSubview(betweenView2)
            stackView.addArrangedSubview(fullNameTxtFld)
            view.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(label.snp.bottom).offset(100)
            }
            
            view.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(view.frame.width / 2 - 100)
                make.top.equalTo(stackView.snp.bottom).offset(50)
                make.height.equalTo(200)
                make.width.equalTo(200)
            }
            
            view.addSubview(doneButton)
            doneButton.snp.makeConstraints { make in
                make.left.equalTo(100)
                make.right.equalTo(-100)
                make.height.equalTo(50)
                make.top.equalTo(imageView.snp.bottom).offset(50)
            }
            
        }
    func didSetupProfile() {
    userNameTxtFld.text = ""
    fullNameTxtFld.text = ""
    imageView.image = UIImage(systemName: "plus.circle")
    }
    
    func didtapImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
}
