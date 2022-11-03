//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import SnapKit
class ProfileViewController: UIViewController {
    let profileTableView = UITableView()
    let profileTableHeaderView = ProfileTableViewHeader()
    private var isStatusBarHidden: Bool = true
    private let statusBar = UIView()
    private let backButton = UIButton()
    
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureProfileTableView()
        configureStatusBar()
        configureButtons()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileTableView.frame  = view.bounds
    }
    
    private func configureButtons(){
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.layer.cornerRadius = 12
        backButton.clipsToBounds = true
        backButton.backgroundColor = .tertiarySystemBackground
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        
        
        
        
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(50)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        
        
        
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

    
    private func configureProfileTableView() {
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        navigationController?.navigationBar.isHidden = true
        
        
        profileTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: view.bounds.height / 3))
        profileTableView.tableHeaderView = headerView
        view.addSubview(profileTableView)
    }
    

}


extension ProfileViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        cell.delegate = self
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
    
    @objc func didTapBackButton(_ sender:UIButton){
        print("zdadas")
        
    }
}


extension ProfileViewController:TweetTableViewCellProtocol {
    func PPtapped() {
        
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
