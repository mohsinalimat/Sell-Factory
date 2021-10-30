//
//  DatabaseManager.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit
import Firebase

final class DatabaseManager {
    
    //MARK: - Properties
    static let shared = DatabaseManager()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadURl
    }
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Inputs Date and returns a safe Date
    /// - Parameter date: Date()
    /// - Returns: Date String
    static func safeDate(date: Date) -> String {
        let safeDate = date
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy_HHmmssSSSS"
        let result = formatter.string(from: safeDate)
        return result
    }
    
    
    
    
    /// Gets the Current User Uid
    /// - Returns: string
    static func getCurrentUid() -> String {
        guard let uid = Auth.auth().currentUser?.uid else { return "" }
        return uid
    }
    
    
    
    
    
    
    /// Checks if Current User is Logged In
    /// - Parameter completion: completion
    /// - Returns: Bool
    public func checkIfLoggedIn(completion: @escaping (Bool) -> ()) {
        if Auth.auth().currentUser == nil {
            completion(false)
        } else {
            completion(true)
        }
    }
    
    
    
    
    
    /// Creates a user in Firebase
    /// - Parameters:
    ///   - firstName: String
    ///   - lastName: String
    ///   - emailId: String
    ///   - password: String
    ///   - profileImage: UIImage
    ///   - completion: completion
    /// - Returns: Bool
    public func createUser(with firstName: String, lastName: String, emailId: String, password: String, profileImage: UIImage, completion: @escaping (Bool) -> ()) {
        
        //create user
        Auth.auth().createUser(withEmail: emailId, password: password, completion: { user, error in
            if let error = error {
                print("DEBUG: Error Creating User with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            //user was created
            guard let uploadData = profileImage.jpegData(compressionQuality: 0.5) else { return }
            let fileName = UUID().uuidString
            
            //upload profile image to firebase
            STORAGE_PROFILE_IMAGE_REF.child(fileName).putData(uploadData, metadata: nil, completion: { metadata, error in
                if let error = error {
                    print("DEBUG: Failed to upload Profile Image with Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                //profile image was added
                //get download URL
                STORAGE_PROFILE_IMAGE_REF.child(fileName).downloadURL(completion: { url, error in
                    if let error = error {
                        print("DEBUG: Failed to get download URL with error: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    //got the download url
                    guard let profileImageURL = url?.absoluteString else { return }
                    //unwrap user uid
                    guard let currentUid = Auth.auth().currentUser?.uid else { return }
                    //create dictionary
                    let dictionaryValues = [USER.firstName: firstName,
                                            USER.lastName: lastName,
                                            USER.emailID: emailId,
                                            USER.profileImageURL: profileImageURL,
                                            USER.currentUid: currentUid,
                                            USER.profileImageFileName: fileName,
                                            USER.bio: "",
                                            USER.country: "",
                                            USER.phoneNumber: ""]
                    
                    let addressValues = [DELIVER_ADDRESS.apartmentOrHouseNumber: "",
                                         DELIVER_ADDRESS.addressLineOne: "",
                                         DELIVER_ADDRESS.addressLineTwo: "",
                                         DELIVER_ADDRESS.streetNumber: "",
                                         DELIVER_ADDRESS.country: "",
                                         DELIVER_ADDRESS.state: "",
                                         DELIVER_ADDRESS.city: "",
                                         DELIVER_ADDRESS.zipCode: ""]
                    
                    
                    let values = [currentUid: dictionaryValues]
                    let deliveryValues = [currentUid: addressValues]
                    //write user data to firebase realtime database
                    USER_REF.updateChildValues(values, withCompletionBlock: { error, ref in
                        if let error = error {
                            print("DEBUG: Error Writing user details to database with error: \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                        //write delivery address
                        DELIVERY_ADD_REF.updateChildValues(deliveryValues, withCompletionBlock: { error, ref in
                            if let error = error {
                                print("DEBUG: Error writing users delivery details to ref with error: \(error.localizedDescription)")
                                completion(false)
                                return
                            }
                            //written to database
                            completion(true)
                        })
                    })
                })
            })
        })
    }
    
    
    
    
    
    
    /// Logins user to Firebase
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    ///   - completion: completion
    /// - Returns: Bool
    public func loginUser(with email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
            if let error = error {
                print("DEBUG: Error Signing User IN with error: \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
        })
    }
    
    
    
    
    
    
    /// Logs out the user
    /// - Parameter completion: completion
    /// - Returns: Bool
    public func logoutCurrentUser(completion: @escaping (Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print("DEBUG: Error Signing Out")
            completion(false)
        }
    }
    
    
    
    
    
    /// Fetches user from the database
    /// - Parameters:
    ///   - uid: user id
    ///   - completion: completion
    /// - Returns: User Object
    public func fetchUser(with uid: String, completion: @escaping (User) -> ()) {
        USER_REF.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        })
    }
    
    
    
    
    
    /// Fetches Delivery Address of the user
    /// - Parameters:
    ///   - uid: Current UID
    ///   - completion: completion
    /// - Returns: Delivery Address Object
    public func fetchDeliveryAddress(with uid: String, completion: @escaping (DeliveryAddress) -> ()) {
        DELIVERY_ADD_REF.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let deliver = DeliveryAddress(dictionary: dictionary)
            completion(deliver)
        })
    }

    
    

    /// Uploads Image To Firebase Storage
    /// - Parameters:
    ///   - data: image data
    ///   - fileName: string
    ///   - completion: completion
    public func uploadPicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        STORAGE_PROFILE_IMAGE_REF.child(fileName).putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            STORAGE_PROFILE_IMAGE_REF.child(fileName).downloadURL(completion: { url, error in
                guard let url = url else {
                    completion(.failure(StorageErrors.failedToGetDownloadURl))
                    return
                }
                let urlString = url.absoluteString
                print("DEBUG: Download URL Returned")
                completion(.success(urlString))
            })
        })
    }
    
    
    
    
    
    /// Uploads Product Image To Firebase Storage
    /// - Parameters:
    ///   - data: image data
    ///   - fileName: string
    ///   - completion: completion
    public func uploadProductPictures(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        STORAGE_PRODUCT_IMG_REF.child(fileName).putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            STORAGE_PRODUCT_IMG_REF.child(fileName).downloadURL(completion: { url, error in
                guard let url = url else {
                    completion(.failure(StorageErrors.failedToGetDownloadURl))
                    return
                }
                let urlString = url.absoluteString
                print("DEBUG: Download URL Returned")
                completion(.success(urlString))
            })
        })
    }
    
    
    
    
    
    
    

    
    
    
    
    
    
    /// Updates User Profile
    /// - Parameters:
    ///   - firstname: string
    ///   - lastname: string
    ///   - bio: string
    ///   - country: string
    ///   - phoneNumber: string
    ///   - completion: completion
    /// - Returns: bool
    public func updateUserProfile(firstname: String, lastname: String, bio: String, country: String, phoneNumber: String, completion: @escaping (Bool) -> ()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        if firstname.trimmingCharacters(in: .whitespaces).isEmpty ||
            lastname.trimmingCharacters(in: .whitespaces).isEmpty {
            completion(false)
            return
        }
        USER_REF.child(currentUid).child(USER.firstName).setValue(firstname)
        USER_REF.child(currentUid).child(USER.lastName).setValue(lastname)
        USER_REF.child(currentUid).child(USER.bio).setValue(bio)
        USER_REF.child(currentUid).child(USER.country).setValue(country)
        USER_REF.child(currentUid).child(USER.phoneNumber).setValue(phoneNumber)
        completion(true)
    }
    
    
    
    
    
    
    /// Creates A Product In the Firebase Data Base
    /// - Parameters:
    ///   - category: String
    ///   - dictionary: Product Object
    ///   - completion: completion
    /// - Returns: Bool 
    public func createProduct(category: String, with dictionary: Dictionary<String, AnyObject>, completion: @escaping (Bool) -> ()) {
        let productID = NSUUID().uuidString
        let values = [productID: dictionary]
        
        //add to products node
        PRODUCTS_REF.updateChildValues(values, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: ERrro in adding to products ref with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            //added to products ref...now add to category ref
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            CURRENT_USER_PRODUCTS_REF.child(currentUid).updateChildValues([productID: 1])
            DB_REF.child(category).updateChildValues([productID: 1])
            completion(true)
        })
    }
    
    
    
    
    
    
    
    /// Updates the product in Firebase
    /// - Parameters:
    ///   - productID: String
    ///   - dictionary: Product Dictionary
    ///   - completion: completion
    /// - Returns: bool
    public func updateProduct(productID: String, dictionary: Dictionary<String, AnyObject>, completion: @escaping (Bool) -> ()) {
        PRODUCTS_REF.child(productID).updateChildValues(dictionary, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: error in updating products with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    
    
    
    

    
    
    
    /// Deletes the Product from the references
    /// - Parameters:
    ///   - productID: String
    ///   - currentUid: String
    ///   - category: String
    ///   - completion: Completion
    /// - Returns: Bool
    public func deleteProduct(with productID: String, currentUid: String, category: String, completion: @escaping (Bool) -> ()) {
        //remove from products ref
        PRODUCTS_REF.child(productID).removeValue(completionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Failed to delete from Products Ref with error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("DEBUG: Removed from Products Ref")
                //remove from category ref
                DB_REF.child(category).child(productID).removeValue(completionBlock: { error, ref in
                    if let error = error {
                        print("DEBUG: Failed to remove from category ref with error: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        print("DEBUG: Removed from category ref")
                        //remove from current user products ref
                        CURRENT_USER_PRODUCTS_REF.child(currentUid).child(productID).removeValue(completionBlock: { error, ref in
                            if let error = error {
                                print("DEBUG: Failed to remove from Current User Products Ref with error: \(error.localizedDescription)")
                                completion(false)
                            } else {
                                print("DEBUG: Successfully Deleted from current User ref")
                                completion(true)
                            }
                        })
                    }
                })
            }
        })
    }
    
    
    
    
    
    
    
    
    
    
    /// Deletes Product Images
    /// - Parameters:
    ///   - fileName: image filename
    ///   - completion: completion
    /// - Returns: bool
    public func deleteProductImageFromFirebase(with fileName: String, completion: @escaping (Bool) -> ()) {
        STORAGE_PRODUCT_IMG_REF.child(fileName).delete(completion: { error in
            if let error = error {
                print("DEBUG: Failed to Delete Image with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
            print("DEBUG: SuccessFully Deleted Image")
        })
    }
    
    
    
    
    
    
    /// Deletes Profile Picture
    /// - Parameters:
    ///   - fileName: old picture filename
    ///   - completion: completion
    /// - Returns: bool
    public func deleteOlderProfilePicture(with fileName: String, completion: @escaping (Bool) -> ()) {
        STORAGE_PROFILE_IMAGE_REF.child(fileName).delete(completion: { error in
            if let error = error {
                print("DEBUG: Failed to Delete Image with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
            print("DEBUG: SuccessFully Deleted Image")
        })
    }
    
    
    
    
    /// Fetches all Products From Firebase
    /// - Parameters:
    ///   - productID: String
    ///   - completion: completion
    /// - Returns: Product Object
    public func fetchAllProducts(with productID: String, completion: @escaping (Product) -> ()) {
        PRODUCTS_REF.child(productID).observeSingleEvent(of: .value, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            guard let ownerID = dictionary[PRODUCT.ownerID] as? String else { return }
            
            DatabaseManager.shared.fetchUser(with: ownerID, completion: { user in
                let product = Product(productID: productID, user: user, dictionary: dictionary)
                completion(product)
            })
        })
    }
    
    
    
    
    
    
    
    /// Updates Delivery Address of User
    /// - Parameters:
    ///   - currentUid: String
    ///   - dictionary: Delivery Address Dictionary
    ///   - completion: completion
    /// - Returns: Bool
    public func updateUsersDeliverAddress(with currentUid: String, dictionary: Dictionary<String, AnyObject>, completion: @escaping (Bool) -> ()) {
        let deliveryValues = [currentUid: dictionary]
        DELIVERY_ADD_REF.updateChildValues(deliveryValues, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Failed to update Delivery Address with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    
    
    
    
    
    ///Adds Product to the Report Ref
    public func reportProduct(productID: String, completion: @escaping (Bool) -> ()) {
        let values = [productID: 1]
        REPORT_REF.updateChildValues(values, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Error Reporting Product with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("DEBUG: Reported")
            completion(true)
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// Saves Product to Product Ref for Current User
    /// - Parameters:
    ///   - productID: String
    ///   - completion: completion
    /// - Returns: Bool
    public func saveProductForUser(productID: String, completion: @escaping (Bool) -> ()) {
        let uid = DatabaseManager.getCurrentUid()
        let values = [productID: 1]
        SAVED_REF.child(uid).updateChildValues(values, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Error Saving Product In Products Ref with error: \(error.localizedDescription)")
                completion(false)
                return 
            }
            print("DEBUG: Product Saved")
            completion(true)
        })
    }
    
    
    
    
    
    
    /// Removes Product From Saved Reference
    /// - Parameters:
    ///   - productID: String
    ///   - completion: completion
    /// - Returns: bool
    public func deleteProductFromSavedRef(productID: String, completion: @escaping (Bool) -> ()) {
        let uid = DatabaseManager.getCurrentUid()
        SAVED_REF.child(uid).child(productID).removeValue(completionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Error In Deleting from Saved Ref with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("DEBUG: Removed From Saved Ref")
            completion(true)
        })
    }
    
    
    
    
    
    
    
    
    /// Places an order in firebase
    /// - Parameters:
    ///   - productID: strning
    ///   - sellerID: string
    ///   - buyerID: string
    ///   - completion: completion
    /// - Returns: bool
    public func placeOrder(productID: String, sellerID: String, buyerID: String, type: Int, completion: @escaping (Bool) -> ()) {
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        let values = [NOTIFICATION_MODEL.didCheck: 0,
                      NOTIFICATION_MODEL.creationDate: creationDate,
                      NOTIFICATION_MODEL.productID: productID,
                      NOTIFICATION_MODEL.type: type,
                      NOTIFICATION_MODEL.buyerID: buyerID,
                      NOTIFICATION_MODEL.sellerID: sellerID] as [String: Any]
        
        let soldValues = [NOTIFICATION_MODEL.didCheck: 0,
                          NOTIFICATION_MODEL.creationDate: creationDate,
                          NOTIFICATION_MODEL.productID: productID,
                          NOTIFICATION_MODEL.type: NOTIFICATION_MODEL.Sold,
                          NOTIFICATION_MODEL.buyerID: buyerID,
                          NOTIFICATION_MODEL.sellerID: sellerID] as [String: Any]
        
        
        //Add To Notifications Ref
        NOTIFICATIONS_REF.child(buyerID).childByAutoId().updateChildValues(values, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Error in adding to notifications ref with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            //Add Product to Purchased Ref for current uid
            PURCHASED_REF.child(buyerID).updateChildValues([productID: 1], withCompletionBlock: { error, ref in
                if let error = error {
                    print("DEBUG: Error in adding to purchased ref with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                //Add Product to Received Orders Ref for buyer uid
                let sellerValues = [NOTIFICATION_MODEL.sellerID: sellerID,
                                    NOTIFICATION_MODEL.buyerID: buyerID,
                                    NOTIFICATION_MODEL.productID: productID]
                RECEIVED_ORDERS_REF.child(sellerID).childByAutoId().updateChildValues(sellerValues, withCompletionBlock: { error, ref in
                    if let error = error {
                        print("DEBUG: Error in adding to received ref with error: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    //remove one item from stock
                    DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                        if var instock = product.itemsInStock {
                            instock -= 1
                            PRODUCTS_REF.child(productID).child(PRODUCT.itemsInStock).setValue(instock, withCompletionBlock: { error, ref in
                                if let error = error {
                                    print("DEBUG: Error in updating stock items with error: \(error.localizedDescription)")
                                    completion(false)
                                    return
                                }
                                //add notification to seller
                                NOTIFICATIONS_REF.child(sellerID).childByAutoId().updateChildValues(soldValues, withCompletionBlock: { error, ref in
                                    if let error = error {
                                        print("DEBUG: Error in updating sellers notification with error: \(error.localizedDescription)")
                                        completion(false)
                                        return
                                    }
                                    //updated
                                    completion(true)
                                })
                            })
                        }
                    })
                })
            })
        })
    }
    
    
    
    
    
    
    /// Fetches notification for current user
    /// - Parameters:
    ///   - uid: string
    ///   - completion: notification object
    /// - Returns: notification object
    public func fetchNotifications(for uid: String, completion: @escaping (Notifications) -> ()) {
        NOTIFICATIONS_REF.child(uid).observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else { return }
            guard let buyerID = dictionary[NOTIFICATION_MODEL.buyerID] as? String else { return }
            DatabaseManager.shared.fetchUser(with: buyerID, completion: { user in
                //if notification is for product
                if let productId = dictionary[NOTIFICATION_MODEL.productID] as? String {
                    DatabaseManager.shared.fetchAllProducts(with: productId, completion: { product in
                        let notification = Notifications(user: user, product: product, dictionary: dictionary)
                        completion(notification)
                    })
                } else {
                    //if notifcation is for message
                    let notification = Notifications(user: user, dictionary: dictionary)
                    completion(notification)
                }
            })
        })
    }
    
    
    
    
    
    
    /// Fetches Received Orders for current User
    /// - Parameters:
    ///   - uid: Current user id
    ///   - completion: completion
    /// - Returns: notification object with buyer user and product which was bought
    public func fetchReceivedOrdersForUser(for uid: String, completion: @escaping (Notifications) -> ()) {
        RECEIVED_ORDERS_REF.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ snapshot in
                let notificationID = snapshot.key
                RECEIVED_ORDERS_REF.child(uid).child(notificationID).observeSingleEvent(of: .value, with: { snapshot in
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    guard let buyerID = dictionary[NOTIFICATION_MODEL.buyerID] as? String else { return }
                    guard let productID = dictionary[NOTIFICATION_MODEL.productID] as? String else { return }
                    DatabaseManager.shared.fetchUser(with: buyerID, completion: { user in
                        DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                            let notification = Notifications(user: user, product: product, dictionary: dictionary)
                            completion(notification)
                        })
                    })
                })
            })
        })
    }
    
    
    
    
    
    
    
    /// Sends the message to firebase
    /// - Parameters:
    ///   - from: user id
    ///   - to: chat partner id
    ///   - message: text
    ///   - completion: completion
    /// - Returns: bool
    public func sendMessages(from: String, to: String, message: String, completion: @escaping (Bool) -> ()) {
        let creationDate = Int(NSDate().timeIntervalSince1970)
        let messageValue = [MessageModel.creationDate: creationDate,
                            MessageModel.toID: to,
                            MessageModel.fromID: from,
                            MessageModel.messageText: message] as [String: Any]
        
        let messageID = NSUUID().uuidString
        MESSAGES_REF.child(messageID).updateChildValues(messageValue, withCompletionBlock: { error, ref in
            if let error = error {
                print("DEBUG: Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            USER_MESSAGES_REF.child(from).child(to).updateChildValues([messageID: 1], withCompletionBlock: { error, ref in
                if let error = error {
                    print("DEBUG: Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                USER_MESSAGES_REF.child(to).child(from).updateChildValues([messageID: 1], withCompletionBlock: { error, ref in
                    if let error = error {
                        print("DEBUG: Error: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    completion(true)
                })
            })
        })
    }
    
    
    
    
    
    
    
    /// Fetches message from firebase
    /// - Parameters:
    ///   - messageID: string
    ///   - completion: completion
    /// - Returns: message object
    public func fetchMessage(with messageID: String, completion: @escaping (Message) -> ()) {
        MESSAGES_REF.child(messageID).observeSingleEvent(of: .value, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else { return }
            let message = Message(dictionary: dictionary)
            completion(message)
        })
    }
    
    
    
    
    
    
    
}

