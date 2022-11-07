//
//  HomeViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class HomeViewModel {
    
    func fetchUser(completion:@escaping (User)->Void){
        guard let uuid = currentU?.uid else {return}
        UserService.shared.fetchUser(uuid: uuid, completion: completion)
            
        
    }
}
