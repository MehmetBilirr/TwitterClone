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
    private let userImageView = UIImageView()
    private let tweetTxtView = UITextView()
    let tweetService = TweetService()
    let tweetVM = TweetViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        ConfigureBarButton()
        style()
        layout()
        setup()
    }
    
    
    private func setup(){
        tweetVM.delegate = self
        tweetVM.fetchUserImage()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    private func ConfigureBarButton(){
        
        tweetButton.configureStyle(title: "  Tweet  ", titleColor: .white)
        tweetButton.layer.cornerRadius = 10
        tweetButton.clipsToBounds = true
        tweetButton.backgroundColor = .systemBlue
        tweetButton.addTarget(self, action: #selector(tapTweetButton(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: tweetButton)
        navigationItem.rightBarButtonItem = barButton
        
        
        
        
        
    }
    
    private func style(){
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFit
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 25
        userImageView.layer.masksToBounds = true

        
        tweetTxtView.translatesAutoresizingMaskIntoConstraints = false
        tweetTxtView.textColor = .black
        tweetTxtView.delegate = self
        tweetTxtView.textColor = .gray
        tweetTxtView.text = "What's happening?"
        tweetTxtView.font = .systemFont(ofSize: 18, weight: .regular)
        
        
                
        
        
        
    }
    
    private func layout(){
     
        view.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        view.addSubview(tweetTxtView)
        
        tweetTxtView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(2)
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview()
            make.height.equalTo(200)
            
            
        }
    }
    
    @objc func tapTweetButton(_ sender:UIButton) {
        
        guard let text = tweetTxtView.text else {return}
        
        tweetService.createData(caption: text)
        navigationController?.popViewController(animated: true)
    }
    
}



extension TweetViewController:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        if tweetTxtView.text.isEmpty || tweetTxtView.text == "What's happening?" {
            
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if tweetTxtView.text.isEmpty {
            textView.textColor = .gray
            textView.text = "What's happening?"
        }
    }
}


extension TweetViewController:TweetViewModelProtocol{
    func getImageUrl(url: String) {
        userImageView.sd_setImage(with: URL(string: url))
    }
    
    
}
