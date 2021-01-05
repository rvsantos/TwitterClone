//
//  User.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 17/12/20.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}
