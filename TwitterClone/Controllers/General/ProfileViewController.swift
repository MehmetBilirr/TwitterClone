//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import SnapKit
import Firebase
import ProgressHUD

protocol ProfileViewControllerPorotocol:AnyObject {
    func didLogOut()
}

class ProfileViewController: UIViewController {
    let profileTableView = UITableView()
    let profileTableHeaderView = ProfileTableViewHeader()
    private var isStatusBarHidden: Bool = true
    private let statusBar = UIView()
    private let backButton = UIButton()
    private let logOutButton =  UIButton()
    let profileVM = ProfileViewModel()
    let headerView = ProfileTableViewHeader(frame: .zero)
    let searchVC = SearchViewController()
    var tweetArray = [Tweet]()
    let tweetService = TweetService()
    
    private let addButton = UIButton()
    
    static weak var delegate : ProfileViewControllerPorotocol?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureProfileTableView()
        configureStatusBar()
        configureButtons()
        configureAddButton()
        setup()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileTableView.frame  = view.bounds
    }
    
  
    
    private func setup(){
        SearchViewController.delegate = self
        profileVM.delegate = self
        headerView.delegate = self
        tabBarController?.tabBar.isHidden = false
         
        
    }
    
    private func configureButtons(){
        
        let logOutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logOutImage, style: .plain, target: self, action: #selector(didLogOutButton(_:)))
        
        
        
        
    }
    
    private func configureStatusBar(){
        statusBar.backgroundColor = .systemBackground
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.layer.opacity = 0
        view.addSubview(statusBar)
        
        statusBar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
    }
    
    private func configureAddButton(){
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus")
        
        addButton.setImage(image, for: .normal)
        
        addButton.layer.cornerRadius = 25
        addButton.clipsToBounds = true
        addButton.backgroundColor = .systemBlue
        addButton.tintColor = .white
        addButton.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        
        
        
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            
            make.height.equalTo(UIScreen.main.bounds.height / 17)
            make.width.equalTo(UIScreen.main.bounds.width / 8)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-UIScreen.main.bounds.height / 10)
        }
        
        
        
    }

    
    private func configureProfileTableView() {
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        
        
        
        profileTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        
        headerView.frame = CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: view.bounds.height / 3 + 50)
        profileTableView.tableHeaderView = headerView
        
        view.addSubview(profileTableView)
    }
    

}


extension ProfileViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        let tweet = tweetArray[indexPath.row]
        cell.delegate = self
        cell.configure(tweet: tweet)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        print(yPosition)
        if yPosition > 150 && isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }

        } else if yPosition < 0 && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
        }
    }
    
}

extension ProfileViewController{
    
    
    @objc func didLogOutButton(_ sender:UIButton) {
        
        profileVM.logOut()
        
        
    }
    
    @objc func didTapAddButton(_ sender:UIButton){
        let vc = TweetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfileViewController:TweetTableViewCellProtocol {
    func tweetTableViewCellDidTapLike(tweet: Tweet) {
        
    }
    
    func PPtapped(user: User) {
        
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


extension ProfileViewController:SearchViewControllerProtocol {
    func didTapCell(user: User) {
        headerView.configure(user: user)
        
    }
    
    
}

extension ProfileViewController:ProfileViewModelProtocol {
    func didLogOut() {
        navigationController?.popViewController(animated: true)
        ProfileViewController.delegate?.didLogOut()
    }
    
    
}

extension ProfileViewController:ProfileTableViewHeaderProtocol {
    func didTapTweetsSection(user:User) {
        guard let id = user.uid else {return}
        tweetService.fetchUserData(uuid: id) { tweets in
            self.tweetArray = tweets
            self.profileTableView.reloadData()
            print("user section")
        }
    }
    
    func didTapLikeSection(user:User) {
        guard let id = user.uid else {return}
        tweetService.fetchLikedTweets(uid: id) { tweets in
            self.tweetArray = tweets
        }

        profileTableView.reloadData()
        
        
        
        
    }
    
    
}
