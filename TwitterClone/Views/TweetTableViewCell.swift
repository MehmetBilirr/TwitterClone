//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import SnapKit



protocol TweetTableViewCellProtocol:AnyObject {
    func tweetTableViewCellDidTapReply()
    func tweetTableViewCellDidTapRetweet()
    func tweetTableViewCellDidTapLike(tweet:Tweet)
    func tweetTableViewCellDidTapShare()
    func PPtapped(user:User)
}

class TweetTableViewCell: UITableViewCell {
    static let identifier = "TweetTableViewCell"
    private let userImageView = UIImageView()
    private let userStackView = UIStackView()
    private let nameLbl = UILabel()
    private let userNameLbl = UILabel()
    private let tweetLbl = UILabel()
    private let buttonStackView = UIStackView()
    private let replyButton = UIButton()
    private let retweetButton = UIButton()
    private let likeButton = UIButton()
    private let shareButton = UIButton()
    weak var delegate: TweetTableViewCellProtocol?
    var chosenUser = User(fullname: "", imageUrl: "", username: "")
    var chosenTweet = Tweet(caption: "", timestamp: Date(), likes: 0)
    let tweetService = TweetService()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stylee()
        layout()
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func stylee(){
        userImageView.configureStyle(contntMode: .scaleAspectFit)
        userImageView.layer.cornerRadius = 25
        userImageView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        userImageView.addGestureRecognizer(tapGesture)
        userImageView.isUserInteractionEnabled = true
        
        userStackView.configureStyle(axiS: .horizontal, space: 5)
        
        userNameLbl.configureStyle(size: 14, weight: .regular, color: .gray)
        userNameLbl.numberOfLines = 1
        
        nameLbl.configureStyle(size: 12, weight: .bold, color: .black)

        tweetLbl.configureStyle(size: 14, weight: .regular, color: .black)
        
        buttonStackView.configureStyle(axiS: .horizontal, space: 70)
        
        replyButton.translatesAutoresizingMaskIntoConstraints = false
        replyButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        replyButton.tintColor = .systemGray2
        replyButton.addTarget(self, action: #selector(didTapReply(_:)), for: .touchUpInside)
        
        
        retweetButton.translatesAutoresizingMaskIntoConstraints = false
        retweetButton.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        retweetButton.tintColor = .systemGray2
        retweetButton.addTarget(self, action: #selector(didTapRetweet(_:)), for: .touchUpInside)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(didTapLike(_:)), for: .touchUpInside)
        
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemGray2
        shareButton.addTarget(self, action: #selector(didTapShare(_:)), for: .touchUpInside)
        
    }
    
    private func layout(){
        contentView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        userStackView.addArrangedSubview(nameLbl)
        userStackView.addArrangedSubview(userNameLbl)
        contentView.addSubview(userStackView)
        
        userStackView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(tweetLbl)
        tweetLbl.snp.makeConstraints { make in
            make.left.equalTo(userStackView.snp.left)
            make.top.equalTo(userStackView.snp.bottom)
            make.right.equalToSuperview().offset(-10)
            
        }
        
        buttonStackView.addArrangedSubview(replyButton)
        buttonStackView.addArrangedSubview(retweetButton)
        buttonStackView.addArrangedSubview(likeButton)
        buttonStackView.addArrangedSubview(shareButton)
        contentView.addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints { make in
            make.left.equalTo(userStackView.snp.left)
            make.top.equalTo(tweetLbl.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc func didTapProfile(){
        
        delegate?.PPtapped(user: chosenUser)
    }
    
    func configure(tweet:Tweet) {
        guard let user = tweet.user else {return}
        chosenTweet = tweet
        chosenUser = user
        userImageView.sd_setImage(with: URL(string: user.imageUrl))
        userNameLbl.text = "@\(user.username)"
        nameLbl.text = user.fullname
        tweetLbl.text = tweet.caption
        likeButtonProcess(tweet: tweet, button: likeButton)
                
    }
    
    func likeButtonProcess(tweet:Tweet,button:UIButton){
        
        tweetService.checkIfUserLikedTweet(tweet: tweet) { didLike in
            if didLike {
                button.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                button.tintColor = .red
                
            }else {
                button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                button.tintColor = .systemGray2
                
                
            }
        }

    }
    
}



// Extension - Buttons Action
extension TweetTableViewCell {
    
    
    
    @objc func didTapReply(_ sender:UIButton){
        delegate?.tweetTableViewCellDidTapReply()
    }
    
    @objc func didTapRetweet(_ sender:UIButton){
        delegate?.tweetTableViewCellDidTapRetweet()
    }
    
    @objc func didTapLike(_ sender:UIButton){
        print("didtapliked")
        delegate?.tweetTableViewCellDidTapLike(tweet: chosenTweet)
        tweetService.checkIfUserLikedTweet(tweet: chosenTweet) { didLike in
            if didLike {
                self.tweetService.unlikeTweet(tweet: self.chosenTweet) {
                    self.chosenTweet.didLike = false
                    self.likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                    self.likeButton.tintColor = .systemGray2
                }
                
            }else {
                
                self.tweetService.likeTweet(tweet: self.chosenTweet) { _ in
                    self.chosenTweet.didLike = true
                    self.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                    self.likeButton.tintColor = .red
                }
                
            }
        }
        
    }
    @objc func didTapShare(_ sender:UIButton){
        
        delegate?.tweetTableViewCellDidTapShare()
    }
    
}
