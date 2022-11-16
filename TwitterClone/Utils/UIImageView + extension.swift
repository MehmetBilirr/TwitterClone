//
//  UIImageView + extension.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 16.11.2022.
//

import Foundation
import UIKit


extension UIImageView {
    
    func configureStyle(contntMode:UIView.ContentMode){
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = contntMode
    }
}
