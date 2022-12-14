//
//  ProfileTableViewHeader.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 2.11.2022.
//

import UIKit
import SnapKit
import SDWebImage

protocol ProfileTableViewHeaderProtocol:AnyObject {
    func didTapLikeSection(user:User)
    func didTapTweetsSection(user:User)
    func didTapTweetsAndReplies(user:User)
    func didTapMedia()
}

class ProfileTableViewHeader: UIView {
    
    private enum  SectionTabs:String {
        
        case tweets = "Tweets"
        case tweetsReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
    }
    
    private var leftSnap = [SnapKit.ConstraintItem]()
    private var rightSnağ = [SnapKit.ConstraintItem]()
    private let headerImageView = UIImageView()
    private let userImageView = UIImageView()
    private let userStackView = UIStackView()
    private let nameLbl = UILabel()
    private let userNameLbl = UILabel()
    private let userBioLbl = UILabel()
    private let dateImageView = UIImageView()
    private let dateLbl = UILabel()
    private let followingStackView = UIStackView()
    private let followerStackView = UIStackView()
    private let followingCountLbl = UILabel()
    private let followingLbl = UILabel()
    private let followersCountLbl = UILabel()
    private let followersLbl = UILabel()
    var editButton = UIButton()
    weak var delegate:ProfileTableViewHeaderProtocol?
    var chosenUser : User?
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    var selectedIndex = 0 {
        didSet {
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.6, delay: 0) {
                    self.sectionButtonStack.arrangedSubviews[i].tintColor = self.selectedIndex == i ? .label : .secondaryLabel
                    
                    self.indicator.snp.remakeConstraints { make in
                        make.left.equalTo(self.leftSnap[self.selectedIndex])
                        make.top.equalTo(self.sectionButtonStack.snp.bottom)
                        make.right.equalTo(self.rightSnağ[self.selectedIndex])
                        make.height.equalTo(4)
                        }
                }
            }
        }
    }
    
    private var tabs : [UIButton] = ["Tweets","Tweets & Replies","Media","Likes"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var sectionButtonStack:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.alignment  = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        configureSectionButtons()
        setIndicatorPozition()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func style(){
        headerImageView.configureStyle(contntMode: .scaleAspectFill)
        headerImageView.image = UIImage(named: "headerImage")
        
        userStackView.configureStyle(axiS: .vertical, space: 10)
        
        userImageView.configureStyle(contntMode: .scaleAspectFit)
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = 25

        nameLbl.configureStyle(size: 20, weight: .bold, color: .black)
        
        userNameLbl.configureStyle(size: 16, weight: .regular, color: .gray)

        userBioLbl.configureStyle(size: 16, weight: .regular, color: .black)
        userBioLbl.text = "Thanks for watching!"
        
        dateImageView.translatesAutoresizingMaskIntoConstraints = false
        dateImageView.tintColor = .secondaryLabel
        dateImageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        
        dateLbl.configureStyle(size: 14, weight: .regular, color: .secondaryLabel)
        dateLbl.text = "Joined November 2022"
        
        followerStackView.translatesAutoresizingMaskIntoConstraints = false
        followerStackView.axis = .horizontal
        followerStackView.configureStyle(axiS: .horizontal, space: 2)
        
        followingStackView.configureStyle(axiS: .horizontal, space: 2)
        
        followingCountLbl.configureStyle(size: 14, weight: .bold, color: .black)
        followingCountLbl.text = "258"
        
        followingLbl.configureStyle(size: 14, weight: .regular, color: .secondaryLabel)
        followingLbl.numberOfLines = 1
        followingLbl.text = "Following"
        
        followersCountLbl.configureStyle(size: 14, weight: .bold, color: .black)
        followersCountLbl.text = "1.2 M"
        
        followersLbl.configureStyle(size: 14, weight: .regular, color: .secondaryLabel)
        followersLbl.numberOfLines = 1
        followersLbl.text = "Followers"
        
        editButton.configureStyle(title: "Edit Profile", titleColor: .black)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        editButton.layer.cornerRadius = 20
        editButton.clipsToBounds = true
        editButton.layer.borderColor = UIColor.systemGray2.cgColor
        editButton.layer.borderWidth = 0.1
        editButton.backgroundColor = .systemBackground
    }
    
    private func setIndicatorPozition(){
        
    }
    
    private func layout(){
        
        for i in 0..<tabs.count {
            
            let snapLeft = sectionButtonStack.arrangedSubviews[i].snp.left
            leftSnap.append(snapLeft)
            
            let snapRight = sectionButtonStack.arrangedSubviews[i].snp.right
            rightSnağ.append(snapRight)
            
           
        }
        
        addSubview(headerImageView)
        
        headerImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(-100)
            make.height.equalTo(200)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(headerImageView.snp.bottom).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(headerImageView.snp.bottom).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        userStackView.addArrangedSubview(nameLbl)
        userStackView.addArrangedSubview(userNameLbl)
        addSubview(userStackView)

        userStackView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.left)
            make.top.equalTo(userImageView.snp.bottom).offset(10)
            

        }
        
        addSubview(userBioLbl)
        userBioLbl.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.left)
            make.top.equalTo(userStackView.snp.bottom).offset(20)
        }
        
        addSubview(dateImageView)
        dateImageView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.left)
            make.top.equalTo(userBioLbl.snp.bottom).offset(10)
            
        }
        
        addSubview(dateLbl)
        
        dateLbl.snp.makeConstraints { make in
            make.left.equalTo(dateImageView.snp.right).offset(2)
            make.top.equalTo(userBioLbl.snp.bottom).offset(10)
        }
        
        followingStackView.addArrangedSubview(followingCountLbl)
        followingStackView.addArrangedSubview(followingLbl)
        addSubview(followingStackView)
        
        followingStackView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.left)
            make.top.equalTo(dateLbl.snp.bottom).offset(10)
            
        }
        
        
        followerStackView.addArrangedSubview(followersCountLbl)
        followerStackView.addArrangedSubview(followersLbl)
        addSubview(followerStackView)
        
        followerStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLbl.snp.bottom).offset(10)
            make.left.equalTo(followingStackView.snp.right).offset(4)
            
        }
        
        addSubview(sectionButtonStack)
        sectionButtonStack.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.left)
            make.top.equalTo(followerStackView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.left.equalTo(leftSnap[0])
            make.top.equalTo(sectionButtonStack.snp.bottom)
            make.right.equalTo(rightSnağ[0])
            make.height.equalTo(4)
            
        }
        
    }
    
    private func configureSectionButtons(){
        
        for (i, button) in sectionButtonStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            
            if i == selectedIndex {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
            
            button.addTarget(self, action: #selector(didTapSectionButton(_:)), for: .touchUpInside)
        }
    }
}


extension ProfileTableViewHeader {
    
    @objc func didTapSectionButton(_ sender:UIButton) {
        guard let label = sender.titleLabel?.text else {return}
        guard let user = chosenUser else {return}
        print(label)
        switch label {
        case SectionTabs.tweets.rawValue:
            selectedIndex = 0
            delegate?.didTapTweetsSection(user: user)
        case SectionTabs.tweetsReplies.rawValue:
            selectedIndex = 1
            delegate?.didTapTweetsAndReplies(user: user)
        case SectionTabs.media.rawValue:
            selectedIndex = 2
            delegate?.didTapMedia()
        case SectionTabs.likes.rawValue:
            selectedIndex = 3
            delegate?.didTapLikeSection(user: user)
            
        default:
            return selectedIndex = 0
        }
        
        
    }
    
    func configure(user:User) {
        userNameLbl.text = ("@\(user.username)")
        nameLbl.text = user.fullname
        userImageView.sd_setImage(with: URL(string: user.imageUrl))
        chosenUser = user
    }
}
