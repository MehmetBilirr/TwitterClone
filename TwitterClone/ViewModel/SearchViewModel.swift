//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import Foundation


class SearchViewModel {
    
    func fetchUsers(completion:@escaping ([User])->Void){
        
        UserService.shared.fetchUsers(completion: completion)
    }
}
