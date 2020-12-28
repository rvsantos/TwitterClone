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
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
       var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            let tweet = Tweet(tweetID: snapshot.key, dictionary: dictionary)
            tweets.append(tweet)
            completion(tweets)
        }
    }
}
