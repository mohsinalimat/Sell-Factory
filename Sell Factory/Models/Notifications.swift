//
//  Notifications.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/6/21.
//

import Foundation
import UIKit


protocol Printable {
    var description: String  { get }
}



class Notifications {
    
    
    enum NotificationType: Int, Printable {

        case Purchased
        case Sold
        case Message
        
        var description: String {
            switch self {
            case .Purchased: return " was purchased."
            case .Sold: return " was sold."
            case .Message: return " sent a message."
            }
        }
        
        init(index: Int) {
            switch index {
            case 0: self = .Purchased
            case 1: self = .Sold
            case 2: self = .Message
            default: self = .Purchased
            }
        }
    }
    
    
    
    var didCheck = false
    var creationDate: Date!
    var sellerID: String!
    var productID: String!
    var type: Int!
    var notificationType: NotificationType!
    var buyerID: String?
    var user: User!
    var product: Product?
    
    init(user: User, product: Product? = nil, dictionary: Dictionary<String, AnyObject>) {
        self.user = user
        
        if let product = product {
            self.product = product
        }
        
        
        if let didCheck = dictionary[NOTIFICATION_MODEL.didCheck] as? Int {
            if didCheck == 0 {
                self.didCheck = false
            } else {
                self.didCheck = true
            }
        }
        
        
        if let creationDate = dictionary[NOTIFICATION_MODEL.creationDate] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
        if let sellerID = dictionary[NOTIFICATION_MODEL.sellerID] as? String {
            self.sellerID = sellerID
        }
        
        if let buyerID = dictionary[NOTIFICATION_MODEL.buyerID] as? String {
            self.buyerID = buyerID
        }
        
        
        if let productID = dictionary[NOTIFICATION_MODEL.productID] as? String {
            self.productID = productID
        }
        
        if let type = dictionary[NOTIFICATION_MODEL.type] as? Int {
            self.notificationType = NotificationType(index: type)
        }
        
    }
    
    
    
}
