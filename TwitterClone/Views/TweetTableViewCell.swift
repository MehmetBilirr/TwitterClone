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
    func tweetTableViewCellDidTapLike()
    func tweetTableViewCellDidTapShare()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stylee()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func stylee(){
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFit
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 25
        userImageView.layer.masksToBounds = true
        
        userImageView.image = UIImage(named: "UserImage")
        
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.axis = .horizontal
        userStackView.spacing = 5
        
        userNameLbl.translatesAutoresizingMaskIntoConstraints = false
        userNameLbl.textAlignment = .center
        userNameLbl.font = .systemFont(ofSize: 14, weight: .regular)
        userNameLbl.textColor = .gray
        userNameLbl.text = "@mbilir9"
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.textAlignment = .center
        nameLbl.font = .systemFont(ofSize: 12, weight: .bold)
        nameLbl.textColor = .white
        nameLbl.text = "Mehmet Bilir"
        
        tweetLbl.translatesAutoresizingMaskIntoConstraints = false
        tweetLbl.textAlignment = .left
        tweetLbl.font = .systemFont(ofSize: 14, weight: .regular)
        tweetLbl.textColor = .white
        tweetLbl.numberOfLines = 0
        tweetLbl.lineBreakMode = .byWordWrapping
        tweetLbl.text = "Hello There! I am Mehmet Bilir.I'am  currently learning Swift and looking for job as iOS Developer. "
        
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 70
        
        
        replyButton.translatesAutoresizingMaskIntoConstraints = false
        replyButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        replyButton.tintColor = .systemGray2
        replyButton.addTarget(self, action: #selector(didTapReply(_:)), for: .touchUpInside)
        
        
        retweetButton.translatesAutoresizingMaskIntoConstraints = false
        retweetButton.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        retweetButton.tintColor = .systemGray2
        retweetButton.addTarget(self, action: #selector(didTapRetweet(_:)), for: .touchUpInside)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .systemGray2
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
        
        delegate?.tweetTableViewCellDidTapLike()
    }
    @objc func didTapShare(_ sender:UIButton){
        
        delegate?.tweetTableViewCellDidTapShare()
    }
    
}
