//
//  ProfileController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 29/12/20.
//

import UIKit

private let reuseID = "TweetCell"
private let headerID = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    private var user: User
    
    private var tweets = [Tweet]() {
        didSet { self.collectionView.reloadData() }
    }
    
    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        self.fetchTweets()
        self.checkIfUserIsFollowed()
        self.fetchUserStats()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - API
    private func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: self.user) { [weak self] (tweets) in
            guard let self = self else { return }
            self.tweets = tweets
        }
    }
    
    
    private func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: self.user.uid) { [weak self] (isFollowed) in
            guard let self = self else { return }
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    
    private func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: self.user.uid) { [weak self] stats in
            guard let self = self else { return }
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: - Helpers
    private func configureCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInsetAdjustmentBehavior = .never
        
        self.collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseID)
        self.collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind:
                                        UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
}


// MARK: - UICollectionViewDataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! ProfileHeader
        
        header.configure(with: self.user, delegate: self)
        
        return header
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 120)
    }
}


// MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func handleEditProfileFollow(_ header: ProfileHeader) {
        
        if self.user.isCurrentUser {
            print("DEBUG: Go to edit profile")
            return
        }
        
        if self.user.isFollowed {
            UserService.shared.unfollowUser(uid: self.user.uid) { [weak self] (error, ref) in
                guard let self = self else { return }
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.shared.followUser(uid: self.user.uid) { [weak self] (error, ref) in
                guard let self = self else { return }
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
    
    
    func handleDismissal() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - TWeetCellDelegate
extension ProfileController: TWeetCellDelegate {
    
    func handleProfileImageTapped(_ cell: TweetCell) {}
}
