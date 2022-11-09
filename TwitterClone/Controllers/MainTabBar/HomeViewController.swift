//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage
import ProgressHUD


class HomeViewController: UIViewController {
    private let addButton = UIButton()
    private let timeLineTableView = UITableView()
    private let profileVC = ProfileViewController()
    private let homeVM = HomeViewModel()
    var currentUser = User(fullname: "", imageUrl: "", username: "")
    private let userImageView = UIImageView()
    private let tweetService = TweetService()
    var tweetArray = [Tweet]()
    var chosenTweet : Tweet?
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        configureTableView()
        configureAddButton()
        configureNavigationBar()
        configureRefreshControl()

    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        homeVM.fetchUser()
        
        
    }
    private func setup() {
        
        homeVM.delegate = self
        homeVM.fetchTweets()
        
    }
    
    
    private func configureTableView(){
        view.addSubview(timeLineTableView)
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
        timeLineTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        
        
    }
    
    func configureRefreshControl(){
        
            
            refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
            timeLineTableView.refreshControl = refreshControl
        
    }
    
    


    private func configureNavigationBar(){
        let size:CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "twitterLogo")
        navigationItem.titleView = logoImageView
        
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
    
    private func configureAddButton(){
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus")
        
        addButton.setImage(image, for: .normal)
        
        addButton.layer.cornerRadius = 25
        addButton.clipsToBounds = true
        addButton.backgroundColor = .systemBlue
        addButton.tintColor = .white
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        
        
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            
            make.height.equalTo(UIScreen.main.bounds.height / 17)
            make.width.equalTo(UIScreen.main.bounds.width / 8)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-UIScreen.main.bounds.height / 10)
        }
        
        
        
    }
    
    

}


// Extension - Button
extension HomeViewController {
    
    @objc func didTapProfile() {
        let vc = ProfileViewController()
        vc.headerView.configure(user: currentUser)
        homeVM.fetchCurrentUserTweet(viewController: vc)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapAddButton(){
        let vc = TweetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshContent(){
        tweetArray = []
        homeVM.fetchTweets()
        timeLineTableView.reloadData()
        refreshControl.endRefreshing()
        
        
    }
}

//Extension - TableView
extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        let tweet = tweetArray[indexPath.row]

        cell.configure(tweet: tweet)
        cell.delegate = self
        return cell
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let defaultOffset = view.safeAreaInsets.top
        
        let offset = scrollView.contentOffset.y + defaultOffset
        print(scrollView.contentOffset.y)
        
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y:min(0, -offset))
    }
    
    
    
}

// Extension-Cell Protocol
extension HomeViewController:TweetTableViewCellProtocol {
    func tweetTableViewCellDidTapLike(tweet: Tweet) {
        tweetService.likeTweet(tweet: tweet) { bool in
            
        }
    }
    
    func PPtapped(user: User) {
        let vc = ProfileViewController()
        vc.headerView.configure(user: user)
        guard let uid = user.uid else {return}
        guard let currentUser = Auth.auth().currentUser else {return}
        homeVM.fetchChosenUserTweet(uuid: uid, viewController: vc)
        vc.headerView.editButton.isHidden = uid == currentUser.uid ? false : true
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
    func tweetTableViewCellDidTapReply() {
        print("Reply button tapped.")
        
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("Retweet button tapped.")
    }
    
   
    
    func tweetTableViewCellDidTapShare() {
        print("Share button tapped.")
    }
    
    
}

//Extension HomeViewModel Protocol

extension HomeViewController:HomeViewModelProtocol {
    func getUser(user: User) {
        currentUser = user
        
        self.userImageView.sd_setImage(with: URL(string: user.imageUrl))
        print(user.imageUrl)
        
        
    }
    
    func getTweets(tweets: [Tweet]) {
        tweetArray = tweets
        timeLineTableView.reloadData()
    }
    
    
}
