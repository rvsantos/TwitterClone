//
//  TweetHeader.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 09/01/21.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    // MARK:- Properties
    var tweet: Tweet? {
        didSet { self.configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48/2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .lightGray
        return lb
    }()
    
    private let captionLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 20)
        lb.numberOfLines = 0
        return lb
    }()
    
    private let dateLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .lightGray
        lb.textAlignment = .left
        return lb
    }()
    
    private lazy var optionsButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.tintColor = .lightGray
        bt.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        bt.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return bt
    }()
    
    private lazy var retweetsLabel = UILabel()
    private lazy var likesLabel = UILabel()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                        paddingLeft: 8, height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [self.retweetsLabel, self.likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                        paddingLeft: 8, height: 1.0)
        
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let bt = self.createButton(withImageName: "comment")
        bt.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var retweetButton: UIButton = {
        let bt = self.createButton(withImageName: "retweet")
        bt.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var likeButton: UIButton = {
        let bt = self.createButton(withImageName: "like")
        bt.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var sharedButton: UIButton = {
        let bt = self.createButton(withImageName: "share")
        bt.addTarget(self, action: #selector(handleSharedTapped), for: .touchUpInside)
        return bt
    }()
    
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private
    private func configureUI() {
        let labelStack = UIStackView(arrangedSubviews: [self.fullnameLabel, self.usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [self.profileImageView, labelStack])
        stack.spacing = 12
        
        self.addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        self.addSubview(self.captionLabel)
        self.captionLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                 paddingTop: 12, paddingLeft: 16, paddingRight: 16)
        
        self.addSubview(self.dateLabel)
        self.dateLabel.anchor(top: self.captionLabel.bottomAnchor, left: leftAnchor,
                              paddingTop: 20, paddingLeft: 16)
        
        self.addSubview(self.optionsButton)
        self.optionsButton.centerY(inView: stack)
        self.optionsButton.anchor(right: rightAnchor, paddingRight: 8)
        
        self.addSubview(self.statsView)
        self.statsView.anchor(top: self.dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                              paddingTop: 12, height: 40)
        
        let actionStack = UIStackView(arrangedSubviews: [self.commentButton, self.retweetButton,
                                                         self.likeButton, self.sharedButton])
        actionStack.spacing = 72
        
        self.addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 12)
    }

    // MARK:- Selectors
    @objc private func handleProfileImageTapped() {
        print("DEBUG: Go to user profile...")
    }
        
    @objc private func showActionSheet() {
        print("DEBUG: Action sheet appears or not...")
    }
    
    @objc private func handleCommentTapped() {
        print("DEBUG: Button comment is tapped..")
    }
    
    @objc private func handleRetweetTapped() {
        print("DEBUG: Button retweet is tapped..")
    }
    
    @objc private func handleLikeTapped() {
        print("DEBUG: Button like is tapped..")
    }
    
    @objc private func handleSharedTapped() {
        print("DEBUG: Button shared is tapped..")
    }
    

    // MARK:- Private
    private func configure() {
        guard let tweet = self.tweet else { return }
        
        let viewModel = TweetViewModel(tweet: tweet)
        
        self.captionLabel.text = viewModel.captionLabel
        self.fullnameLabel.text = viewModel.fullname
        self.usernameLabel.text = "@\(viewModel.username)"
        self.profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        self.dateLabel.text = viewModel.headerTimestamp
        self.likesLabel.attributedText = viewModel.likesAttributedString
        self.retweetsLabel.attributedText = viewModel.retweetsAttributedString
    }
    
    private func createButton(withImageName imageName: String) -> UIButton {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: imageName), for: .normal)
        bt.tintColor = .darkGray
        bt.setDimensions(width: 20, height: 20)
        return bt
    }
}
