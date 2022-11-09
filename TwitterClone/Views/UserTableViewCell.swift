//
//  UserTableViewCell.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 7.11.2022.
//

import UIKit
import SnapKit


class UserTableViewCell: UITableViewCell {
    private let userImageView = UIImageView()
    private let userNameLbl = UILabel()
    private let nameLbl = UILabel()
    private let userStackView = UIStackView()
    static let identifier = "UserTableViewCell"
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

        userNameLbl.translatesAutoresizingMaskIntoConstraints = false
        userNameLbl.textAlignment = .center
        userNameLbl.font = .systemFont(ofSize: 14, weight: .regular)
        userNameLbl.textColor = .gray
        userNameLbl.text = "@mblr9"
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.textAlignment = .center
        nameLbl.font = .systemFont(ofSize: 12, weight: .bold)
        nameLbl.textColor = .black
        nameLbl.text = "Mehmet Bilir"
        
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.axis = .vertical
        userStackView.spacing = 2
    }
    
    private func layout(){
        
        contentView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        userStackView.addArrangedSubview(nameLbl)
        userStackView.addArrangedSubview(userNameLbl)
        contentView.addSubview(userStackView)
        
        userStackView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(15)
           
        }
        
    }
    
    func configure(user:User) {
        userNameLbl.text = ("@\(user.username)")
        nameLbl.text = user.fullname
        userImageView.sd_setImage(with: URL(string: user.imageUrl))
    }

}
