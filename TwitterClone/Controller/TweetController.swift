//
//  TweetController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 08/01/21.
//

import UIKit

private let headerID = "TweetHeader"
private let tweetID = "TweetCell"

class TweetController: UICollectionViewController {
    
    // MARK:- Properties
    private let tweet: Tweet
    
    // MARK:- Lifecycle
    init(tweet: Tweet) {
        self.tweet = tweet
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        print("DEBUG: Tweet caption is \(tweet.caption)")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    
    // MARK:- Private
    private func configureCollectionView() {
        self.collectionView.backgroundColor = .white
        
        self.collectionView.register(TweetCell.self, forCellWithReuseIdentifier: tweetID)
        self.collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
}


// MARK: - UICollectionViewDelegate
extension TweetController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! TweetHeader
        
        header.tweet = self.tweet
        
        return header
    }
}


// MARK:- UICollectionViewDataSource
extension TweetController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetID, for: indexPath) as! TweetCell
        
        return cell
    }
}


// MARK:- UICollectionViewDelegateFlowLayout
extension TweetController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: self.tweet)
        let height = viewModel.size(forWidth: self.view.frame.width).height
        
        return CGSize(width: self.view.frame.width, height: height + 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 120)
    }
}
