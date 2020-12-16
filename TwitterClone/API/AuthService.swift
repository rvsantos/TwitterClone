//
//  AuthService.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 15/12/20.
//

import UIKit
import Firebase


struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static let shared = AuthService()
    
    
    func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    func registerUser(credentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                fatalError("Error is \(error.localizedDescription)")
            }
            
            guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
            
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                storageRef.downloadURL { (url, error) in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    
                    let values = [
                        "email": credentials.email,
                        "fullname": credentials.fullname,
                        "username": credentials.username,
                        "profileImageUrl": profileImageUrl
                    ]
                    
                    guard let uid = result?.user.uid else { return }
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
