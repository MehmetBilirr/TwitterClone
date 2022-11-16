//
//  HomeViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import ProgressHUD
import UIKit

protocol HomeViewModelInterface:AnyObject{
    var view:HomeViewInterface? {get set}
    var navigationController: UINavigationController?{get set}
    func viewDidLoad()
    func fetchUser()
    func ppTapped(user:User)
    func addButtonTapped()
    func getTweet(at indexpath:IndexPath) -> Tweet
    func getTweetCount() -> Int
    func getUser() -> User
    func viewWillAppear()
    
}
final class HomeViewModel {
    weak var navigationController: UINavigationController?
    weak var view: HomeViewInterface?
    var profileViewController = ProfileViewController()
    var tweetArray = [Tweet]()
    var currentUser = User(fullname: "", imageUrl: "", username: "")
    let tweetViewController = TweetViewController()
    let userService = UserService()
    let tweetService = TweetService()

    private func navigationToViewController(viewController:UIViewController) {
        
        navigationController?.pushViewController(viewController, animated: true)
       
    }
}


extension HomeViewModel:HomeViewModelInterface {
    func viewWillAppear() {
        view?.fetchTweets()
    }
    
    func getUser() -> User {
        return currentUser
    }
    func ppTapped(user: User) {
        guard let uid = user.uid else {return}
        ProgressHUD.show()
        tweetService.fetchUserData(uuid: uid) { [weak self] tweets in
            guard let uid = user.uid else {return}
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
    
    func viewDidLoad() {
        view?.fetchUser()
        view?.fetchTweets()
        view?.configureTableView()
        view?.configureAddButton()
        view?.configureNavigationBar()
        view?.configureRefreshControl()
        
    }
    func fetchUser(){
        guard let uuid = Auth.auth().currentUser?.uid else {return}
        userService.fetchUser(uuid: uuid) { [weak self] user in
            self?.currentUser = user
            self?.view?.getUser(user: user)
            
        }
    }
    func fetchTweets(){
        ProgressHUD.show()
        tweetService.fetchAllData { [weak self] tweets in
            self?.tweetArray = tweets
            self?.view?.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ProgressHUD.dismiss()
            }
        }
    }
    
    func addButtonTapped() {
        navigationToViewController(viewController: tweetViewController)
    }
    
    func getTweet(at indexpath: IndexPath) -> Tweet {
        tweetArray[indexpath.row]
    }
    func getTweetCount() -> Int {
        return tweetArray.count
    }
}
