//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import SDWebImage
import ProgressHUD

protocol HomeViewInterface:AnyObject{
    func configureTableView()
    func configureRefreshControl()
    func configureNavigationBar()
    func configureAddButton()
    func fetchUser()
    func getUser(user:User)
    func fetchTweets()
    func reloadData()
    
}

class HomeViewController: UIViewController {
    private let addButton = UIButton()
    private let timeLineTableView = UITableView()
    let viewModel = HomeViewModel()
    var currentUser = User(fullname: "", imageUrl: "", username: "")
    private let userImageView = UIImageView()

    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.navigationController = navigationController
        viewModel.viewDidLoad()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTableView.frame = view.bounds
        
    }
   
}



// Extension - Button
extension HomeViewController {
    
    @objc func didTapProfile() {
        viewModel.ppTapped(user: currentUser)
        
    }
    
    @objc func didTapAddButton(){
        viewModel.addButtonTapped()
    }
    
    @objc func refreshContent(){
        viewModel.fetchTweets()
        refreshControl.endRefreshing()
    }
}

//Extension - TableView
extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTweetCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        cell.configure(tweet: viewModel.getTweet(at: indexPath))
        cell.delegate = self
        return cell
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        //        let defaultOffset = view.safeAreaInsets.top
        //
        //        let offset = scrollView.contentOffset.y + defaultOffset
        //        print(scrollView.contentOffset.y)
        //
        //
        //        navigationController?.navigationBar.transform = .init(translationX: 0, y:min(0, -offset))
        
    }
    
    
}

// Extension-Cell Protocol
extension HomeViewController:TweetTableViewCellProtocol {
    func tweetTableViewCellDidTapLike(tweet: Tweet) {
    }
    
    func PPtapped(user: User) {
        viewModel.ppTapped(user: user)

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



extension HomeViewController:HomeViewInterface {
  
    
    func configureTableView(){
        view.addSubview(timeLineTableView)
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        timeLineTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        
        
    }
    
    func configureRefreshControl(){
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        timeLineTableView.refreshControl = refreshControl
    }
    
    
    func configureNavigationBar(){
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
    
    func configureAddButton(){
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
    
    func fetchUser() {
        viewModel.fetchUser()
    }
    
    func getUser(user: User) {
        currentUser = user
        self.userImageView.sd_setImage(with: URL(string: user.imageUrl))
    
    }
    
    func fetchTweets() {
        viewModel.fetchTweets()
    }
    

    func reloadData() {
        timeLineTableView.reloadData()
    }
}


