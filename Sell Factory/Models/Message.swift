//
//  Message.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/7/21.
//

import Foundation
import UIKit
import Firebase

class Message {
    
    
    var messageText: String!
    var fromID: String!
    var toID: String!
    var creationDate: Date!
    
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        if let messageText = dictionary[MessageModel.messageText] as? String {
            self.messageText = messageText
        }
        
        if let fromID = dictionary[MessageModel.fromID] as? String {
            self.fromID = fromID
        }
        
        if let toID = dictionary[MessageModel.toID] as? String {
            self.toID = toID
        }
        
        if let creationDate = dictionary[MessageModel.creationDate] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
    }
    
    
    
    func getChatPartnerID() -> String {
        guard let currentUid = Auth.auth().currentUser?.uid else { return "" }
        if fromID == currentUid {
            return toID
        } else {
            return fromID
        }
    }
    
    
    
}
