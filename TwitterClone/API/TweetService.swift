//
//  TweetService.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 25/12/20.
//

import Firebase

class TweetService {
    
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping  (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        let values: [String : Any] = [
            "uid": uid,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "likes": 0,
            "retweets": 0,
            "caption": caption
        ]
        
        let ref = REF_TWEETS.childByAutoId()
        ref.updateChildValues(values) { (error, ref) in
            // update user-tweet structure after tweet update completes
            guard let tweetID = ref.key else { return }
            REF_USERS_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
    }
    
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
       var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetID: snapshot.key, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    
    func fetchTweets(forUser user: User, completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_USERS_TWEETS.child(user.uid).observe(.childAdded) { (snapshot) in
            let tweetID = snapshot.key
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary = snapshot.value as? [String : Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
               
                
                UserService.shared.fetchUser(uid: uid) { (user) in
                    let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
}
