//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import Foundation
protocol SearchViewModelProtocol:AnyObject{
    func getUsers(users:[User])
}

class SearchViewModel {
    let userService = UserService()
    weak var delegate:SearchViewModelProtocol?
    func fetchUsers(){
        
        userService.fetchUsers {  userArray in
            self.delegate?.getUsers(users: userArray)
            
        }
        
        
    }
}
