//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 29/12/20.
//

import UIKit

struct TweetViewModel {
    
    // MARK: - Properties
    private let tweet: Tweet
    private let user: User
    
    var profileImageUrl: URL? {
        return self.user.profileImageUrl
    }
    
    var captionLabel: String {
        return self.tweet.caption
    }
    
    var fullname: String {
        return self.user.fullname
    }
    
    var headerTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ∙ dd/MM/yyyy"
        return formatter.string(from: self.tweet.timestamp)
    }
    
    var username: String {
        return self.user.username
    }

    var timestamp: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        
        return formatter.string(from: self.tweet.timestamp, to: now)
    }
    
    var retweetsAttributedString: NSAttributedString {
        return self.attributedText(withValue: self.tweet.retweetCount, text: "Retweets")
    }
    
    var likesAttributedString: NSAttributedString {
        return self.attributedText(withValue: self.tweet.likes, text: "Likes")
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: self.user.fullname, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(self.user.username)",
                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                     NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        title.append(NSAttributedString(string: " • \(self.timestamp ?? "")",
                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                     NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return title
    }

    
    // MARK: - Initialization
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    
    // MARK: - Private
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold),
                                                                                  .foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = self.tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
