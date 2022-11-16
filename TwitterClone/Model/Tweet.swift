//
//  Tweet.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 8.11.2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase


struct Tweet:Codable {
    
    @DocumentID var id: String?
    var uid:String?
    let caption:String
    let timestamp:Date
    let likes:Int
    
    var user:User?
    var didLike :Bool? = false
}
