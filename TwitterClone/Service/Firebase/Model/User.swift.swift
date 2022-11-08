//
//  User.swift.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation


struct User:Codable {
    var uid:String?
    let fullname:String
    let imageUrl:String
    let username:String
}

