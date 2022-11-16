//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 6.11.2022.
//

import Foundation
import ProgressHUD
import Firebase
import FirebaseFirestoreSwift
import UIKit

protocol ProfileToAppDelegate:AnyObject {
    func didLogOut()
}

protocol ProfileViewModelInterface:AnyObject {
    var view:ProfileViewInterFace? {get set}
    var navigationController:UINavigationController? {get set}
    
    func viewDidLoad()
    func logOut()
    func fetchUserData(uid:String)
    func fetchLikeTweets(uid:String)
    func didTapMedia()
    func addButtonTapped()
    func getTweet(at indexpath:IndexPath) -> Tweet
    func getTweetCount() -> Int
    
}

class ProfileViewModel {
    static var delegate:ProfileToAppDelegate?
    weak var view:ProfileViewInterFace?
    var navigationController: UINavigationController?
    let tweetService = TweetService()
    let authService = AuthService()
    let tweetViewController = TweetViewController()
    var tweetArray = [Tweet]()
        
    private func navigationToViewController(viewController:UIViewController) {
        
        navigationController?.pushViewController(viewController, animated: true)
       
    }
}


extension ProfileViewModel:ProfileViewModelInterface {

    
    func getTweet(at indexpath: IndexPath) -> Tweet {
        tweetArray[indexpath.row]
    }
    
    func getTweetCount() -> Int {
        tweetArray.count
    }
    
   
    
    func viewDidLoad() {
        view?.setup()
        view?.configureProfileTableView()
        view?.configureAddButton()
        view?.configureButtons()
        view?.configureStatusBar()
        
        
        
    }
    
    func logOut(){
           
        
        authService.logOut { bool in
            if bool {
                ProfileViewModel.delegate?.didLogOut()
                navigationController?.popViewController(animated: true)
            }
        }
        
       }
    
    func fetchUserData(uid:String) {
        
        tweetService.fetchUserData(uuid: uid) { [weak self] tweets in
            self?.tweetArray = tweets
            self?.view?.reloadData()
        }
    }
    
    
    func fetchLikeTweets(uid:String) {
        
        tweetService.fetchLikedTweets(uid: uid) { [weak self] tweets in
            self?.tweetArray = tweets
            self?.view?.reloadData()
        }
        
    }
    
    func addButtonTapped() {
        navigationToViewController(viewController: tweetViewController)
    }

    func didTapMedia() {
        tweetArray = []
        view?.reloadData()
    }
   
}
