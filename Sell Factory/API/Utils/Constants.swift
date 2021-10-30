//
//  Constants.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit
import Firebase


//MARK: - Fonts
struct Font {
    //static let menlo = "Menlo-Regular"
    //static let menloBold = "Menlo-Bold"
    static let menlo = "Nunito-Regular"
    static let menloBold = "Nunito-Black"
}



//MARK: - SF Symbols
struct SFSYMBOLS {
    static let PLUS_IMAGE = "plus.circle.fill"
    static let BACK = "arrow.backward"
    static let REFRESH = "arrow.clockwise"
    static let PERSON_CIRCLE = "person.circle.fill"
    static let WIFI = "wifi"
    static let NOWIFI = "wifi.slash"
    static let POST = "plus.app"
    static let SETTINGS = "gearshape"
    static let CART = "cart"
    static let SAVED =  "bookmark"
    static let LOGOUT = "arrow.right.doc.on.clipboard"
    static let MESSAGE = "message"
    static let PAPER_AIRPLANE = "paperplane.fill"
    static let NOTIFICATION = "bell.badge"
    static let TWO_PERSON = "person.2.fill"
    static let LOCK = "lock.fill"
    static let SHIELD = "lock.shield"
    static let CIRCLE_QUESTION = "questionmark.circle.fill"
    static let CIRCLE_EXCLAMATION = "exclamationmark.circle"
    static let PHONE = "phone.fill"
    static let DELIVERY_BOX = "shippingbox.fill"
    static let GRID = "square.grid.2x2.fill"
    static let LIST = "list.bullet"
    static let CROSS = "xmark.circle.fill"
    static let DOT = "ellipsis.circle"
    static let EDIT = "pencil.circle.fill"
    static let DELETE = "trash.fill"
    static let ELLIPISE = "ellipsis"
}



//MARK: - POPUP
struct POPUP {
    static let OOPS = "OOPS"
    static let MISSING_FIELDS = "Looks like some of the fields or Profile Image are missing. Please fill those and try again."
    static let MISSING_FIELDS_2 = "Looks like some of the fields or First Image are missing. Please fill those and try again."
    static let SIGNUP_ERROR = "Something went wrong while Creating your account. Please try again!"
    static let LOGOUT_ERROR = "Failed to Logout! Please Try Again."
    static let LOGIN_ERROR = "Failed to Login! Please Try Again."
    static let MISSING_EMAIL_PASS = "Looks like email or password are missing. Please fill those and try again."
    static let BIO_COUNTRY_MISSING = "Looks like your Bio and Country Detail are missing. Go to Edit Profile to add them."
    static let SUCCESS = "Congratulations"
    static let SUCCESS_MSG = "You Profile Picture was updated. Don't forget to hit SAVE CHANGES button"
    static let PROFILE_IMG_UPDATE_FAILED_MSG = "Failed to update profile picture. Please try Again."
    static let BIO_UPDATED_MSG = "Your Profile was Updated Successfully."
    static let BIO_UPDATED_FAILED_MSG = "Your Profile information failed to update. Please try Again."
    static let GENERAL_ERROR = "Looks like something went wrong, Please Try Again Later."
    static let UPDATED_TITLE = "UPDATED"
    static let UPDATED_MSG = "Your Product was updated successfully."
    static let UPDATE_FAILED = "Something went wrong while updating. Please try again"
    static let MINU_BUTTON_ERROR = "There should be atleast one item in stock to add the product."
}


//MARK: - Alert Controller
struct ALERT {
    static let YES = "Yes"
    static let CANCEL = "CANCEL"
    static let SURE_MSG = "Are you sure you want to delete this?"
    static let TITLE = "Delete?"
}






//MARK: - Texts
struct TXT {
    
    static let APP_TITLE = "Sell Factory"
    static let EMAIL = "✉️ Email ID"
    static let PASSWORD = "🔑 Password"
    static let LOGIN = "Login"
    static let SIGNUP = "Sign Up"
    static let DONT_HAVE_AC = "Don't have an Account?"
    static let ALREADY_AC = "Already have an Account?"
    static let FORGOT_PASS = "Forgot Password?"
    static let FIRST_NAME = "First Name"
    static let LAST_NAME = "Last Name"
    static let RESET_PASS = "Send Reset Link"
    static let REMEMBER_PASS = "Remember Your Password?"
    static let SEARCH = "Search"
    
    static let DOLLAR = "$"
    static let RUPEE = "₹"
    static let POUNDS = "￡"
    static let EUROS = "€"
}


//MARK: - Profile Texts
struct PROFILE_TEXT {
    static let EDIT_PROFILE = "Edit Profile"
    static let POST = "＋ Post"
    static let SETTINGS = "⚙️ Settings"
}





//MARK: - Colors
struct COLORS {
    static let primaryBlue: UIColor = #colorLiteral(red: 0, green: 0.4352941176, blue: 1, alpha: 1)
    static let customLavender: UIColor = #colorLiteral(red: 0.7882352941, green: 0.6941176471, blue: 1, alpha: 1)
    static let customGreen: UIColor = #colorLiteral(red: 0.737254902, green: 1, blue: 0.737254902, alpha: 1)
    static let skyBlur: UIColor = #colorLiteral(red: 0.6352941176, green: 0.9294117647, blue: 1, alpha: 1)
    
    static let colorOne: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.9058823529, alpha: 1)
    static let colorTwo: UIColor = #colorLiteral(red: 0.4941176471, green: 0.6509803922, blue: 0.9568627451, alpha: 1)
    static let colorThree: UIColor = #colorLiteral(red: 0.6274509804, green: 0.8941176471, blue: 0.9450980392, alpha: 1)
    static let colorFour: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9803921569, blue: 0.9843137255, alpha: 1)
}



//MARK: - Caetgory
struct CATEGORY {
    static let ALL_PRODUCTS = "products"
    static let ALL = "All Products"
    static let ELECTRONICS = "🖥 Electronics"
    static let HOME = "🏠 Home"
    static let GARDEN = "🪴 Garden"
    static let CRAFT = "🧵 Craft"
    static let FURNITURE = "🪑 Furniture"
    static let PET = "🐕 Pet Supplies"
    static let CLOTHES = "👔 Clothing"
    static let FOOD = "🍲 Food & Grocery"
    static let TOY = "🧸 Toys"
    static let HANDMADE = "🧶 Handmade"
    static let SPORTS = "⚽️ Sports"
    static let TOOLS = "🛠 Tools"
    static let OTHERS = "Other"
    static let LOCATION = "📍 Location"
    static let ORDERS = "View Orders"
}


//MARK: - Settings Menu
struct SETTINGS_MENU {
    static let EDITPROFILE = "Edit Profile"
    static let SETTINGS = "Settings"
    static let YOUR_ORDERS = "Your Orders"
    static let SAVED = "Saved"
    static let LOGOUT = "Sign Out"
    static let NOTIFICATIONS = "Notifications"
    static let MESSAGES = "Messages"
}



//MARK: - POST PRODUCT
struct POST_PRODUCT_TEXTS {
    static let POST = "Post Product"
    static let ADD_IMAGES = "Add Product Images"
    static let IMG_DESCRIPTION = "The First Image will be used as the cover image."
    static let YES = "Yes"
    static let NO = "No"
    static let INTERNATIONAL = "Is International Shipping available?"
    static let MINUS = " - "
    static let PLUS = " + "
    static let ITEM_IN_STOCK = "Number of Items in Stock"
    static let DELIVERY = " 📦 Delivery in # of Days"
    static let DOLLAR = "$"
    static let RUPEE = "₹"
    static let POUNDS = "￡"
    static let EUROS = "€"
    static let PRICE = "💲Product Price"
    static let NO_CATEGORY = "No Category Selected ˅"
    static let NO_COUNTRY = "Choose Country ˅"
    static let CATEGORY = "Choose Product Category"
    static let DESCRIPTION = "Product Description"
    static let NAME = "Product Name"
    static let CUSTOMIZABLE  = "Is your Product Customizable?"
    static let BLANK_SPACE = "                                 "
    static let UPDATE = "Update Product"
}



//MARK: - Edit Profile Texts
struct EDITPROFILE {
    static let PAGE_TITLE = "Edit Profile"
    static let FIRST_NAME = "First Name"
    static let LAST_NAME = "Last Name"
    static let BIO = "📝 Bio"
    static let COUNTRY = "🏳 Country"
    static let Phone = "📞 Phone Number"
    static let EMAIL = "✉️ Email ID"
    static let UPDATEBIO = "💾 Save Changes"
    static let USERNAME = "@username"
}



//MARK: - SettingsPage Texts
struct SETTINGS_TEXTS {
    static let PAGE_TITLE = "Settings"
    static let INVITE = "Invite Friends"
    static let PRIVACY = "Privacy"
    static let SECURITY = "Security"
    static let HELP = "Help"
    static let ABOUT = "About"
    static let SIGNOUT = "Sign Out"
    static let CONTACT = "Contact Info"
    static let DELIVERY_ADDRESS = "Delivery Address"
}


//MARK: - Your Order Texts
struct YOURORDER_TEXTS {
    static let PAGE_TITLE = "Your Orders"
}



//MARK: - Saved Page Texts
struct SAVED_TEXTS {
    static let PAGE_TITLE = "Saved Products"
}

//MARK: - Saved Page Texts
struct NOTIFICATION_TEXTS {
    static let PAGE_TITLE = "Notifications"
}

//MARK: - Saved Page Texts
struct MESSAGES_TEXTS {
    static let PAGE_TITLE = "Messages"
}


//MARK: - Delivery Address Texts
struct DELIVER_TXT {
    static let house = "House/Apt Number"
    static let add1 = "Address Line 1"
    static let add2 = "Address Line 2"
    static let street = "Street Name/Number"
    static let city = "City"
    static let state = "State"
    static let zip = "Zip Code"
    static let choose = "Choose Country"
    static let update = "Update Address"
    static let title = "Delivery Address"
    static let fieldMissing = "Looks like some of the fields are missing. Please fill and try again"
    static let updatedTitle = "Updated"
    static let updatedMSG = "Your Delivery Address was updated successfully"
    static let failedMSG = "Failed to update your Delivery Address. Please Try Again."
}


//MARK: - Product Details
struct PRODUCT_DETAILS {
    static let TITLE = "Product Details"
    static let PRICE = "Price"
    static let SOLD_BY = "Sold By,"
    static let BUY_NOW = "Buy Now"
    static let SAVE = "Save for Later"
    static let CUSTOM_TITLE = "This Product is customizable. Add your request below for the seller."
}



//MARK: - Confirm Purchase Texts
struct CONFIRM_ORDER_TXTS {
    static let TITLE = "Confirm Order"
    static let ANIMATION = "location"
    static let NOT_UPDATED = "You've not added your Delivery Address. To Confirm your order please update your Address."
    static let CLICK_HERE = "Click Here -> Deliver Address"
    static let DA = "📦 Delivery Address"
    static let MSG = "The Seller will send you a message soon with payment details. To keep this App free we don't offer In-App Payment Methods."
    static let CO = "Confirm Order"
}



//MARK: - Const
struct CONST {
    static let TF_HEIGHT: CGFloat = 45.0
    static let BUTTON_HEIGHT: CGFloat = 45.0
    static let CORNER_RADII: CGFloat = 12.0
}







//MARK: - USER Dictionary
struct USER {
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let emailID = "emailID"
    static let profileImageURL = "profileImageURL"
    static let currentUid = "currentUid"
    static let bio = "bio"
    static let country = "country"
    static let phoneNumber = "phoneNumber"
    static let profileImageFileName = "profileImageFileName"
}


//MARK: - Product Dictionary
struct PRODUCT {
    static let productName = "productName"
    static let productDescription = "productDescription"
    static let productCategory = "productCategory"
    static let productPrice = "productPrice"
    static let productDeliveryInDays = "productDeliveryInDays"
    static let isCustomizable = "isCustomizable"
    static let isInternationalShippingAvailable = "isInternationalShippingAvailable"
    static let itemsInStock = "itemsInStock"
    static let productImages = "productImages"
    static let creationDate = "creationDate"
    static let ownerID = "ownerID"
    static let productID = "productID"
    static let coverImageURL = "coverImageURL"
    static let productImageFileNames = "productImageFileNames"
}



//MARK: - Delivery Address Model
struct DELIVER_ADDRESS {
    static let addressLineOne = "addressLineOne"
    static let addressLineTwo = "addressLineTwo"
    static let streetNumber = "streetNumber"
    static let apartmentOrHouseNumber = "apartmentOrHouseNumber"
    static let zipCode = "zipCode"
    static let city = "city"
    static let state = "state"
    static let country = "country"
}



//MARK: - Report Texts
struct REPORT_TXT {
    static let TITLE = "REPORTED"
    static let MSG = "This Product was  reported successfully. This will be checked and handled by our team. Thank you."
    static let FAILED = "Failed To Report. Try Again!"
    static let FAILED_SAVE = "Failed To Save. Try Again!"
    static let SAVED = "Saved"
}



//MARK: - Notifications Model
struct NOTIFICATION_MODEL {
    static let didCheck = "didCheck"
    static let creationDate = "creationDate"
    static let sellerID = "sellerID"
    static let productID = "productID"
    static let type = "type"
    static let buyerID = "buyerID"
    
    static let Purchased = 0
    static let Sold = 1
    static let Message = 2
}




//MARK: - Message Model
struct MessageModel {
    static let messageText = "messageText"
    static let fromID = "fromID"
    static let toID = "toID"
    static let creationDate = "creationDate"
}






//MARK: - Database References

//MARK: - Root References
let DB_REF = Database.database().reference()
let STORAGE_REF = Storage.storage().reference()


//MARK: - Storage References
let STORAGE_PROFILE_IMAGE_REF = STORAGE_REF.child("profile_images")
let STORAGE_PRODUCT_IMG_REF = STORAGE_REF.child("product_images")

//MARK: - Database References
let USER_REF = DB_REF.child("users")
let CURRENT_USER_PRODUCTS_REF = DB_REF.child("current-user-products")
let PRODUCTS_REF = DB_REF.child("products")
let DELIVERY_ADD_REF = DB_REF.child("delivery-address")
let SAVED_REF = DB_REF.child("saved-products")
let REPORT_REF = DB_REF.child("reported-products")
let NOTIFICATIONS_REF = DB_REF.child("notifications")
let PURCHASED_REF = DB_REF.child("purchased")
let RECEIVED_ORDERS_REF = DB_REF.child("received-orders")
let MESSAGES_REF = DB_REF.child("messages")
let USER_MESSAGES_REF = DB_REF.child("user-messages")
