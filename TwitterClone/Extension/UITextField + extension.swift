//
//  UITextField + extension.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 5.11.2022.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle(){
        
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender:UIButton) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
