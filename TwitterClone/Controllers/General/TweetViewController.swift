//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 8.11.2022.
//

import UIKit
import SnapKit

class TweetViewController: UIViewController {
    private let button = UIButton()
    private let tweetButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
        ConfigureBarButton()
    }
    
    private func ConfigureBarButton(){
        
        tweetButton.translatesAutoresizingMaskIntoConstraints = false
        
        tweetButton.setTitle("  Tweet  ", for: .normal)
        tweetButton.layer.cornerRadius = 10
        tweetButton.clipsToBounds = true
        tweetButton.setTitleColor(.white, for: .normal)
        tweetButton.backgroundColor = .systemBlue
        let barButton = UIBarButtonItem(customView: tweetButton)
        navigationItem.rightBarButtonItem = barButton
    }
    

       

}
