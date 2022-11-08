//
//  Tweet.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 8.11.2022.
//

import Foundation


struct Tweet:Codable {
    
    var uid:String?
    let caption:String
    let timestamp:Date
    let likes:Int
    
    var user:User?
}
