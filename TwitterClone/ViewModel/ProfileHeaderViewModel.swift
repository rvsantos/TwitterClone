//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 29/12/20.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}


struct ProfileHeaderViewModel {
    
    // MARK:- Properties
    private let user: User
    
    let usernameText: String
    
    var followersString: NSAttributedString? {
        return self.attributedText(withValue: self.user.stats?.followers ?? 0, text: " followers")
    }
    
    var followingString: NSAttributedString? {
        return self.attributedText(withValue: self.user.stats?.following ?? 0, text: " following")
    }
    
    var actionButtonTitle: String {
        if self.user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !self.user.isFollowed && !self.user.isCurrentUser {
            return "Follow"
        }
        
        if self.user.isFollowed {
            return "Following"
        }
        
        return "Loading"
    }
    
    
    // MARK:- Initialization
    init(user: User) {
        self.user = user
        
        self.usernameText = "@\(user.username)"
    }
    
    
    // MARK:- Private
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: "\(text)", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold),
                                                                                  .foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
    
}
