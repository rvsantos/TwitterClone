//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 29/12/20.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleDismissal()
    func handleEditProfileFollow(_ header: ProfileHeader)
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    weak var delegate: ProfileHeaderDelegate?
    private let filterBar = ProfileFilterView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(self.backButton)
        self.backButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                               paddingTop: 42, paddingLeft: 16)
        self.backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "backButton").withRenderingMode(.alwaysOriginal), for: .normal)
        bt.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return bt
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        return iv
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Follow", for: .normal)
        bt.layer.borderColor = UIColor.twitterBlue.cgColor
        bt.layer.borderWidth = 1.25
        bt.setTitleColor(.twitterBlue, for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 14)
        bt.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return bt
    }()
    
    private let fullnameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16)
        lb.textColor = .lightGray
        return lb
    }()
    
    private let bioLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16)
        lb.numberOfLines = 3
        lb.text = "This is a user bio that will span more one line for test purposes"
        return lb
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private let followingLabel: UILabel = {
        let lb = UILabel()
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(followTap)
        
        return lb
    }()
    
    private let followersLabel: UILabel = {
        let lb = UILabel()
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(followTap)
        
        return lb
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
    @objc private func handleDismissal() {
        self.delegate?.handleDismissal()
    }
    
    
    @objc private func handleEditProfileFollow() {
        self.delegate?.handleEditProfileFollow(self)
    }
    
    
    @objc private func handleFollowingTapped() {
        
    }
    
    
    @objc private func handleFollowersTapped() {
        
    }

    
    // MARK: - Helpers
    func configure(with user: User, delegate: ProfileHeaderDelegate) {
        self.delegate = delegate
        
        let viewModel = ProfileHeaderViewModel(user: user)
        
        self.profileImageView.sd_setImage(with: user.profileImageUrl)
        
        self.editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        self.followingLabel.attributedText = viewModel.followingString
        self.followersLabel.attributedText = viewModel.followersString
        
        self.fullnameLabel.text = user.fullname
        self.usernameLabel.text = viewModel.usernameText
    }
    
        
    // MARK: - Privatee
    private func configureUI() {
        self.filterBar.delegate = self
        
        self.addSubview(self.containerView)
        self.containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 100)
        
        self.configureProfileImageView()
        self.configureEditProfileFollowButton()
        self.configureLabels()
        self.configureFilterBar()
        self.configureUnderlineView()
    }
    
    
    private func configureProfileImageView() {
        self.addSubview(self.profileImageView)
        self.profileImageView.anchor(top: self.containerView.bottomAnchor, left: leftAnchor,
                                     paddingTop: -24, paddingLeft: 8)
        self.profileImageView.setDimensions(width: 80, height: 80)
        self.profileImageView.layer.cornerRadius = 80/2
    }
    
    
    private func configureEditProfileFollowButton() {
        self.addSubview(self.editProfileFollowButton)
        self.editProfileFollowButton.anchor(top: self.containerView.bottomAnchor, right: rightAnchor,
                                            paddingTop: 12, paddingRight: 12)
        self.editProfileFollowButton.setDimensions(width: 100, height: 36)
        self.editProfileFollowButton.layer.cornerRadius = 36/2
    }
    
    
    private func configureLabels() {
        let stack = UIStackView(arrangedSubviews: [self.fullnameLabel, self.usernameLabel, self.bioLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        self.addSubview(stack)
        stack.anchor(top: self.profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                     paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        let followStack = UIStackView(arrangedSubviews: [self.followingLabel, self.followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        
        self.addSubview(followStack)
        followStack.anchor(top: stack.bottomAnchor, left: leftAnchor,
                           paddingTop: 8, paddingLeft: 12)
    }
    
    
    private func configureFilterBar() {
        self.addSubview(self.filterBar)
        self.filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
    }
    
    
    private func configureUnderlineView() {
        self.addSubview(self.underlineView)
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        self.underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width/count, height: 2)
    }
    
}


extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        
        let xPosition = cell.frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
