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
        
        guard let uuid = Auth.auth().currentUser?.uid else {return}
        print(uuid)
        UserService.shared.fetchUser(uuid: uuid, completion: completion)
            
        
    }
}
