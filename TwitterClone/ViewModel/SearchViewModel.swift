//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import Foundation
import ProgressHUD
import UIKit
import FirebaseAuth


protocol SearchViewModelInterface:AnyObject {
    var view:SearchViewInterface? {get set}
    var navigationController:UINavigationController? {get set}
    func viewDidload()
    func viewWillAppear()
    func fetchUsers()
    func filteredUsers(text:String)
    func numberOfRows()->Int
    func getusers(at indexpath:IndexPath) -> User
    func didSelectRowAt(at indexPath:IndexPath)
    
}

final class SearchViewModel {
    let userService = UserService()

    weak var view: SearchViewInterface?
    weak var navigationController: UINavigationController?
    let profileViewController = ProfileViewController()
    var users = [User]()
    var chosenUser = User(fullname: "", imageUrl: "", username: "")
    var filteredUsers = [User]()
    let tweetService = TweetService()
    
        func fetchChoosenUserTweet(uuid:String,viewController:ProfileViewController) {
            
            tweetService.fetchUserData(uuid: uuid) { tweets in
                viewController.tweetArray = tweets
                viewController.profileTableView.reloadData()
            }
        }
    
    private func navigationToViewController(viewController:UIViewController) {
        
        navigationController?.pushViewController(viewController, animated: true)
       
    }
    private func chosenUserProfile(user:User){
        guard let uid = user.uid else {return}
        print(user)
        ProgressHUD.show()
        tweetService.fetchUserData(uuid: uid) { [weak self] tweets in
            guard let currentUser = Auth.auth().currentUser else {return}
            guard let self = self else {return}
            self.profileViewController.headerView.configure(user: user)
            self.profileViewController.tweetArray = tweets
            self.profileViewController.profileTableView.reloadData()
            self.profileViewController.headerView.editButton.isHidden = uid == currentUser.uid ? false : true
            ProgressHUD.dismiss()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationToViewController(viewController: self.profileViewController)
        }
    }
}

extension SearchViewModel:SearchViewModelInterface {
    func filteredUsers(text: String) {
        
        filteredUsers = users.filter({ user in
            if text != "" {
                
                let re =  user.fullname.lowercased().contains(text) || user.username.lowercased().contains(text)
                return re
            }else {
                return false
            }
            
        })
        view?.reloadData()
    }
    

    
    func viewDidload() {
        view?.configureTableView()
    }
    
    
    func viewWillAppear() {
        view?.fetchUsers()
    }
    
    func fetchUsers(){
        ProgressHUD.show()
        userService.fetchUsers {  userArray in
            self.users = userArray
            self.view?.reloadData()
            ProgressHUD.dismiss()
        }
        
    }
    
    func numberOfRows() -> Int {
        if (view?.isActive)! {
            return filteredUsers.count
        }else {
            return users.count
        }
    }
    
    func getusers(at indexpath: IndexPath) -> User {
        
        if (view?.isActive)! {
            return filteredUsers[indexpath.row]
        }else {
            return users[indexpath.row]
        }
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        if (view?.isActive)! {
            let user = filteredUsers[indexPath.row]
            chosenUserProfile(user: user)
            
        }else {
            let user = users[indexPath.row]
            chosenUserProfile(user: user)
        }
    }
}
