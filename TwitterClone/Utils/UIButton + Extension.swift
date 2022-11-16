//
//  UIButton + Extension.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 16.11.2022.
//

import Foundation
import UIKit


extension UIButton {
    
    func configureStyle(title:String,titleColor:UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)

        
        
    }
}
