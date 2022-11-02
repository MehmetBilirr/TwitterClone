//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit

class HomeViewController: UIViewController {

    let timeLineTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureNavigationBar()
        configureTableView()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTableView.frame = view.bounds
    }
    
    
    private func configureTableView(){
        view.addSubview(timeLineTableView)
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
        timeLineTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        
        
    }

    private func configureNavigationBar(){
        let size:CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "twitterLogo")
        navigationItem.titleView = logoImageView
        
    
        
        
        
        let userImageView = UIImageView()
        userImageView.image = UIImage(named: "UserImage")
        userImageView.layer.cornerRadius = 20
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFit
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        userImageView.addGestureRecognizer(tapGesture)
        userImageView.isUserInteractionEnabled = true
        userImageView.frame.size = CGSize(width: 36, height: 36)
        
        let backButtonItem = UIBarButtonItem()
        backButtonItem.customView = UIView(frame: CGRect(x:0, y:0, width: 36, height: 36))
        backButtonItem.customView?.addSubview(userImageView)
        navigationItem.leftBarButtonItem = backButtonItem
        
        
        let sparklesImage = UIImage(systemName: "sparkles")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: sparklesImage, style: .plain, target: self, action: nil)
        
    }

}


// Extension - Button
extension HomeViewController {
    
    @objc func didTapProfile() {
        print("profile button tapped")
    }
}

//Extension - TableView
extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    
}

// Extension-Cell Protocol
extension HomeViewController:TweetTableViewCellProtocol {
    func tweetTableViewCellDidTapReply() {
        print("Reply button tapped.")
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("Retweet button tapped.")
    }
    
    func tweetTableViewCellDidTapLike() {
        print("Like button tapped.")
    }
    
    func tweetTableViewCellDidTapShare() {
        print("Share button tapped.")
    }
    
    
}
