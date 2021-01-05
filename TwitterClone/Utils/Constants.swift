//
//  Constants.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 15/12/20.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
let REF_USERS_TWEETS = DB_REF.child("user-tweets")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
