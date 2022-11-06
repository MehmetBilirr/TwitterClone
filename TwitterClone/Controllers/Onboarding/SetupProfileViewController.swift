//
//  SetupProfileViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import UIKit
import SnapKit
import FirebaseStorage
import FirebaseFirestore
import Firebase
import ProgressHUD
class SetupProfileViewController: UIViewController {

    private let label = UILabel()
    private let mailTxtFld = UITextField()
    private let userNameTxtFld = UITextField()
    private let fullNameTxtFld = UITextField()
    private let stackView = UIStackView()
    private let betweenView1 = UIView()
    private let betweenView2 = UIView()
    private let imageView = UIImageView()
    private let doneButton = UIButton()
    private let setupProfileVM = SetupProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }
    

    
    private func style(){
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Get started.\n Create your profile"
        
        
        userNameTxtFld.translatesAutoresizingMaskIntoConstraints = false
        userNameTxtFld.placeholder = "Username"
        
        fullNameTxtFld.translatesAutoresizingMaskIntoConstraints = false
        fullNameTxtFld.placeholder = "Full Name"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
  
        
        betweenView2.translatesAutoresizingMaskIntoConstraints = false
        betweenView2.backgroundColor = .secondarySystemFill
        betweenView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        imageView.addGestureRecognizer(tapGesture)

        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: .normal)
        doneButton.layer.cornerRadius = 20
        doneButton.clipsToBounds = true
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
    }
    
    private func layout(){
        
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
   

}


extension SetupProfileViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func didTapImage(_ sender:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func didTapToDismiss(){
        view.endEditing(true)
    }
    
    @objc func didTapDoneButton(_ sender:UIButton){
        guard let username = userNameTxtFld.text,let fullName = fullNameTxtFld.text,let image = imageView.image else {return}
        
        if  userNameTxtFld.text == "" {
            ProgressHUD.showError("Username cannot be empty")
        }else if fullNameTxtFld.text == ""{
            ProgressHUD.showError("Full name cannot be empty")
        }else {
            
            setupProfileVM.setupProfile(imageView: imageView, userName: username, fullName: fullName)

        }
        
        
        
        
        
        
        
        
        
}

}
