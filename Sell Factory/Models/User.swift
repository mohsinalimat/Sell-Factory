//
//  User.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import Foundation
import Firebase
import UIKit

class User {
    var bio: String!
    var country: String!
    var currenUid: String!
    var emailID: String!
    var firstName: String!
    var lastName: String!
    var phoneNumber: String!
    var profileImageURL: String!
    var uid: String!
    var profileImageFileName: String!
    
    init(uid: String, dictionary: Dictionary<String, AnyObject>) {
        self.uid = uid
        
        if let bio = dictionary[USER.bio] as? String {
            self.bio = bio
        }
        
        if let country = dictionary[USER.country] as? String {
            self.country = country
        }
        
        if let currentUid = dictionary[USER.currentUid] as? String {
            self.currenUid = currentUid
        }
        
        if let emailID = dictionary[USER.emailID] as? String {
            self.emailID = emailID
        }
        
        if let firstName = dictionary[USER.firstName] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictionary[USER.lastName] as? String {
            self.lastName = lastName
        }
        
        if let phoneNumber = dictionary[USER.phoneNumber] as? String {
            self.phoneNumber = phoneNumber
        }
        
        if let profileImageURL = dictionary[USER.profileImageURL] as? String {
            self.profileImageURL = profileImageURL
        }
        
        if let profileImageFileName = dictionary[USER.profileImageFileName] as? String {
            self.profileImageFileName = profileImageFileName
        }
        
    }
}
