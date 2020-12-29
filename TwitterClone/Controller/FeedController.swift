//
//  FeedController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit
import SDWebImage

private let reusableID = "TweetCell"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet { self.configureProfileImageViewBarItem() }
    }
    
    private var tweets = [Tweet]() {
        didSet { self.collectionView.reloadData() }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.fetchTweets()
    }
    
    
    // MARK: - API
    private func fetchTweets() {
        TweetService.shared.fetchTweets { [weak self] (tweets) in
            guard let self = self else { return }
            self.tweets = tweets
        }
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        self.configureCollectionView()
        
        self.view.backgroundColor = .systemBackground
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        self.navigationItem.titleView = imageView
    }
    
    
    private func configureCollectionView() {
        self.collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reusableID)
        self.collectionView.backgroundColor = .white
    }
    
    
    private func configureProfileImageViewBarItem() {
        guard let user = self.user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.clipsToBounds = true
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}


// MARK: - Extension UICollectionView
extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableID, for: indexPath) as! TweetCell
        
        cell.tweet = self.tweets[indexPath.row]
        
        return cell
    }
}


// MARK: - Extension UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 120)
    }
}
