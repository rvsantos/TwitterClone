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

    var timestamp: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        
        return formatter.string(from: self.tweet.timestamp, to: now)
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
}
