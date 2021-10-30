//
//  DeliveryAddress.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/2/21.
//

import Foundation
import UIKit

class DeliveryAddress {
    
    var addressLineOne: String!
    var addressLineTwo: String!
    var streetNumber: String!
    var apartmentOrHouseNumber: String!
    var zipCode: String!
    var city: String!
    var state: String!
    var country: String!
    
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        if let addressLineOne = dictionary[DELIVER_ADDRESS.addressLineOne] as? String {
            self.addressLineOne = addressLineOne
        }
        
        if let addressLineTwo = dictionary[DELIVER_ADDRESS.addressLineTwo] as? String {
            self.addressLineTwo = addressLineTwo
        }
        
        if let streetNumber = dictionary[DELIVER_ADDRESS.streetNumber] as? String {
            self.streetNumber = streetNumber
        }
        
        if let apartmentOrHouseNumber = dictionary[DELIVER_ADDRESS.apartmentOrHouseNumber] as? String {
            self.apartmentOrHouseNumber = apartmentOrHouseNumber
        }
        
        if let zipCode = dictionary[DELIVER_ADDRESS.zipCode] as? String {
            self.zipCode = zipCode
        }
        
        if let city = dictionary[DELIVER_ADDRESS.city] as? String {
            self.city = city
        }
        
        if let state = dictionary[DELIVER_ADDRESS.state] as? String {
            self.state = state
        }
        
        if let country = dictionary[DELIVER_ADDRESS.country] as? String {
            self.country = country
        }
    }
    
    
    
}
