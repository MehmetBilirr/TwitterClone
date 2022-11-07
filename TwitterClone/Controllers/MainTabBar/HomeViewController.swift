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


class HomeViewController: UIViewController {
    let addButton = UIButton()
    let timeLineTableView = UITableView()
    let profileVc = ProfileViewController()
    let homeVM = HomeViewModel()
    let userImageView = UIImageView()
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureNavigationBar()
        configureTableView()
        configureAddButton()
        
        
        
        
        
        
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
        
      
        homeVM.fetchUser { User in
            self.userImageView.sd_setImage(with: URL(string: User.imageUrl))
        }
        
       
        
        
        
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
        homeVM.fetchUser { User in
            vc.headerView.configure(user: User)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapAddButton(){
        print("add button tapped")
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let defaultOffset = view.safeAreaInsets.top
        
        let offset = scrollView.contentOffset.y + defaultOffset
        print(scrollView.contentOffset.y)
        
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y:min(0, -offset))
    }
    
    
    
}

// Extension-Cell Protocol
extension HomeViewController:TweetTableViewCellProtocol {
    func PPtapped() {
        
        let vc = ProfileViewController()
        homeVM.fetchUser { User in
            vc.headerView.configure(user: User)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
