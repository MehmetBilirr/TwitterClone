//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       configureNavigationBar()
    }
    

    private func configureNavigationBar(){
        let size:CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "twitterLogo")
        navigationItem.titleView = logoImageView
        
        
        let profileImage = UIImage(systemName: "person")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile(_:)))
    }

}

extension HomeViewController {
    
    @objc func didTapProfile(_ sender:UIButton) {
        print("profile button tapped")
    }
}
