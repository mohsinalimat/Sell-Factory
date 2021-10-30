//
//  Product.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/30/21.
//

import Foundation
import UIKit

class Product {
    
    var productName: String!
    var productDescription: String!
    var productCategory: String!
    var productPrice: String!
    var productDeliveryInDays: String!
    var isCustomizable: String!
    var isInternationalShippingAvailable: String!
    var itemsInStock: Int!
    var productImages: [String]!
    var creationDate: Date!
    var ownerID: String!
    var productID: String!
    var user: User?
    var coverImageURL: String!
    var productImageFileNames: [String]!
    
    
    init(productID: String, user: User, dictionary: Dictionary<String, AnyObject>) {
        self.productID = productID
        self.user = user
        
        
        if let productName = dictionary[PRODUCT.productName] as? String {
            self.productName = productName
        }
        
        if let productDescription = dictionary[PRODUCT.productDescription] as? String {
            self.productDescription = productDescription
        }
        
        if let productCategory = dictionary[PRODUCT.productCategory] as? String {
            self.productCategory = productCategory
        }
        
        if let productPrice = dictionary[PRODUCT.productPrice] as? String {
            self.productPrice = productPrice
        }
        
        if let productDeliveryInDays = dictionary[PRODUCT.productDeliveryInDays] as? String {
            self.productDeliveryInDays = productDeliveryInDays
        }
        
        if let isCustomizable = dictionary[PRODUCT.isCustomizable] as? String {
            self.isCustomizable = isCustomizable
        }
        
        if let isInternationalShippingAvailable = dictionary[PRODUCT.isInternationalShippingAvailable] as? String {
            self.isInternationalShippingAvailable = isInternationalShippingAvailable
        }
        
        
        if let itemsInStock = dictionary[PRODUCT.itemsInStock] as? Int {
            self.itemsInStock = itemsInStock
        }
        
        if let productImages = dictionary[PRODUCT.productImages] as? [String] {
            self.productImages = productImages
        }
        
        
        if let creationDate = dictionary[PRODUCT.creationDate] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
        if let ownerID = dictionary[PRODUCT.ownerID] as? String {
            self.ownerID = ownerID
        }
        
        if let coverImageURL = dictionary[PRODUCT.coverImageURL] as? String {
            self.coverImageURL = coverImageURL
        }
        
        if let productImageFileNames = dictionary[PRODUCT.productImageFileNames] as? [String] {
            self.productImageFileNames = productImageFileNames
        }
        
    }
    
    
}



//MARK: - ProductImage View Model
struct ProductImagesCellViewModel {
    var url: [String]
    
    init(with model: ProductImageModel) {
        url = model.url
    }
}


struct ProductImageModel {
    var url: [String]
}
