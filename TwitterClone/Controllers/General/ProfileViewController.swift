//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileTableView = UITableView()
    let profileTableHeaderView = ProfileTableViewHeader()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureProfileTableView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileTableView.frame  = view.bounds
    }

    
    private func configureProfileTableView() {
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
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
        return cell
    }
    
    
}
