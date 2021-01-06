//
//  UserCell.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 06/01/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK:- Properties
    var user: User? {
        didSet { self.configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 32, height: 32)
        iv.layer.cornerRadius = 32/2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.text = "Username"
        return lb
    }()
    
    private let fullnameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.text = "Fullname"
        return lb
    }()
    
    // MARK:- Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Private
    private func configure() {
        guard let user = self.user else { return }
        self.profileImageView.sd_setImage(with: user.profileImageUrl)
        self.usernameLabel.text = user.username
        self.fullnameLabel.text = user.fullname
    }
    
    
    private func configureUI() {
        self.addSubview(self.profileImageView)
        self.profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [self.usernameLabel, self.fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        self.addSubview(stack)
        stack.centerY(inView: self.profileImageView, leftAnchor: self.profileImageView.rightAnchor, paddingLeft: 12)
    }
}
