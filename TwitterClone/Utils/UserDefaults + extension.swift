//
//  LocalState.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 14.11.2022.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys:String {
        case hasOnSetup
    }
    
    var hasOnSetup:Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnSetup.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultsKeys.hasOnSetup.rawValue)
        }
    }
}
