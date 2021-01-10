//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 28/12/20.
//

import UIKit

protocol TWeetCellDelegate: class {
    func handleProfileImageTapped(_ user: User)
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    weak var delegate: TWeetCellDelegate?
    
    private var tweet: Tweet?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48/2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.numberOfLines = 0
        lb.text = "Some test caption"
        return lb
    }()
    
    private let infoLabel = UILabel()
    
    private lazy var commentButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "comment"), for: .normal)
        bt.tintColor = .darkGray
        bt.setDimensions(width: 20, height: 20)
        bt.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var retweetButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "retweet"), for: .normal)
        bt.tintColor = .darkGray
        bt.setDimensions(width: 20, height: 20)
        bt.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var likeButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "like"), for: .normal)
        bt.tintColor = .darkGray
        bt.setDimensions(width: 20, height: 20)
        bt.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var shareButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "share"), for: .normal)
        bt.tintColor = .darkGray
        bt.setDimensions(width: 20, height: 20)
        bt.addTarget(self, action: #selector(handleSharedTapped), for: .touchUpInside)
        return bt
    }()

    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
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
    
    
    @objc private func handleProfileImageTapped() {
        guard let user = self.tweet?.user else { return }
        self.delegate?.handleProfileImageTapped(user)
    }
    
    
    // MARK: - Helpers
    func configure(tweet: Tweet, delegate: TWeetCellDelegate) {
        self.tweet = tweet
        self.delegate = delegate
        
        let viewModel = TweetViewModel(tweet: tweet)
        
        self.profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        self.captionLabel.text = viewModel.captionLabel
        self.infoLabel.attributedText = viewModel.userInfoText
    }
    
    
    // MARK: - Private
    private func configureUI() {
        backgroundColor = .white
        
        self.configureProfileImageView()
        self.configureStackView()
        self.configureUnderlineView()
    }
    
    
    private func configureProfileImageView() {
        self.addSubview(self.profileImageView)
        self.profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [self.infoLabel, self.captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: self.profileImageView.topAnchor, left: self.profileImageView.rightAnchor, right: rightAnchor,
                     paddingLeft: 12, paddingRight: 12)
        
        let actionStack = UIStackView(arrangedSubviews: [self.commentButton, self.retweetButton, self.likeButton, self.shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
    }
    
    
    private func configureUnderlineView() {
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
    }
}
