//
//  ConfirmPurchaseVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/2/21.
//

import UIKit
import Firebase
import Lottie
import SDWebImage

class ConfirmPurchaseVC: UIViewController {
    
    //MARK: - Properties
    var deliveryAddress: DeliveryAddress?
    var product: Product?
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let refreshButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.REFRESH, color: .label)
        button.addTarget(self, action: #selector(handleRefreshButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let pageTitleLabel = SFLabel(texxt: CONFIRM_ORDER_TXTS.TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    
    //Lottie Animation
    private let animationView: AnimationView = {
        let animate = AnimationView()
        animate.loopMode = .loop
        animate.contentMode = .scaleAspectFit
        animate.animation = Animation.named(CONFIRM_ORDER_TXTS.ANIMATION)
        animate.backgroundColor = .clear
        animate.isHidden = true
        return animate
    }()
    
    
    private let notUpdatedAddressFieldsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.menlo, size: 14)
        label.textColor = .label
        label.text = CONFIRM_ORDER_TXTS.NOT_UPDATED
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    
    private let goToDeliveryAddressVCLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.menloBold, size: 16)
        label.textColor = .label
        label.text = CONFIRM_ORDER_TXTS.CLICK_HERE
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.isHidden = true
        return label
    }()
    
    
    
    
    
    //other product details
    private let productCoverImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.layer.borderColor = COLORS.customLavender.cgColor
        iv.layer.borderWidth = 1.2
        iv.isHidden = true
        return iv
    }()
    
    private let productTitleLabel = SFLabel(texxt: "", fontName: Font.menloBold,
                                            fontSize: 16, noOfLines: 0,
                                            texxtColor: .label, texxtAlignment: .left)
    
    private let productPriceLabel = SFLabel(texxt: "", fontName: Font.menloBold,
                                            fontSize: 16, noOfLines: 0,
                                            texxtColor: .label, texxtAlignment: .left)
    
    private let addressTitleLabel = SFLabel(texxt: CONFIRM_ORDER_TXTS.DA, fontName: Font.menlo,
                                            fontSize: 12, noOfLines: 1,
                                            texxtColor: .secondaryLabel, texxtAlignment: .left)
    
    //address details labels
    private let lineOneLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    
    private let lineTwoLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    private let apartmentHouseOrNumber = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    private let streetNumberORNameLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    private let cityLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    private let stateLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    private let countryLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    private let zipCodeLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                       fontSize: 12, noOfLines: 0, texxtColor: .label,
                                       texxtAlignment: .left)
    
    
    private let addressStack: SFStackView = {
        let stack = SFStackView(stackAxis: .vertical, stackSpace: 8)
        stack.isHidden = true
        return stack
    }()
    
    
    
    private let otherDetailsLabel = SFLabel(texxt: CONFIRM_ORDER_TXTS.MSG, fontName: Font.menlo, fontSize: 12, noOfLines: 0, texxtColor: .secondaryLabel, texxtAlignment: .left)
    
    
    private let confirmOrderButton: SFButton = {
        let button = SFButton(placeHolder: CONFIRM_ORDER_TXTS.CO)
        button.addTarget(self, action: #selector(handleConfirmOrderTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let editAddressButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.EDIT, color: .label)
        button.addTarget(self, action: #selector(handleEditAddressTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    private let goToHomeScreenButton: SFButton = {
        let button = SFButton(placeHolder: "🛍 Shop More")
        button.isHidden = true
        button.addTarget(self, action: #selector(handleGoToHomeButtonTapped), for: .touchUpInside)
        return button
    }()

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        animationView.play()
        fetchDeliveryAddress()
        setupProductDetails()
    }
    
    
    
    
    
    
    //MARK: - Helpers
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
        
    }
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    /// Handles Refresh and Checks if Address is Filled
    @objc private func handleRefreshButtonTapped() {
        generateFeedback()
        fetchDeliveryAddress()
    }
    
    
    
    
    /// Goes To Delivery Address View Controller
    @objc private func handleGoToDeliveryAddressVC() {
        generateFeedback()
        navigationController?.pushViewController(DeliveryAddressVC(), animated: true)
    }
    
    
    
    
    
    /// Handles Confirm Order Tap
    @objc private func handleConfirmOrderTapped() {
        generateFeedback()
        print("DEBUG: Confirm Order Pressed")
        confirmOrder()
    }
    
    
    
    
    /// Handles Edit Address Tapped
    @objc private func handleEditAddressTapped() {
        generateFeedback()
        print("DEBUG: Edit Address Here")
        navigationController?.pushViewController(DeliveryAddressVC(), animated: true)
    }
    
    
    
    
    
    /// Handles Go To Home Screen Tapped
    @objc private func handleGoToHomeButtonTapped() {
        generateFeedback()
        let vc = UINavigationController(rootViewController: HomeVC())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: {
            self.navigationController?.removeViewController(ConfirmPurchaseVC.self)
        })
    }
    
    
    
    
    
}
//MARK: - Extensions
extension ConfirmPurchaseVC {
    
    
    
    
    /// Layouts Views for this VC
    private func configureViews() {
        //add Sub view
        view.addSubview(backButton)
        view.addSubview(refreshButton)
        view.addSubview(pageTitleLabel)
        view.addSubview(animationView)
        view.addSubview(notUpdatedAddressFieldsLabel)
        view.addSubview(goToDeliveryAddressVCLabel)
        view.addSubview(productCoverImageView)
        view.addSubview(productTitleLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(addressTitleLabel)
        view.addSubview(addressStack)
        //add to address stack
        addressStack.addArrangedSubview(apartmentHouseOrNumber)
        addressStack.addArrangedSubview(lineOneLabel)
        addressStack.addArrangedSubview(lineTwoLabel)
        addressStack.addArrangedSubview(streetNumberORNameLabel)
        addressStack.addArrangedSubview(countryLabel)
        addressStack.addArrangedSubview(stateLabel)
        addressStack.addArrangedSubview(cityLabel)
        addressStack.addArrangedSubview(zipCodeLabel)
        //other
        view.addSubview(confirmOrderButton)
        view.addSubview(otherDetailsLabel)
        view.addSubview(editAddressButton)
        
        
        view.addSubview(goToHomeScreenButton)

        
        //Layout views
        
        goToHomeScreenButton.centerX(inView: view)
        goToHomeScreenButton.centerY(inView: view)
        
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        refreshButton.centerY(inView: pageTitleLabel)
        refreshButton.anchor(right: view.rightAnchor,
                             paddingRight: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
        //animation
        animationView.centerX(inView: view)
        animationView.centerY(inView: view)
        let dim = view.frame.size.width/2
        animationView.setDimensions(height: dim, width: dim)
        
        //Not Updated Labels
        notUpdatedAddressFieldsLabel.anchor(top: nil,
                                            left: view.leftAnchor,
                                            bottom: animationView.topAnchor,
                                            right: view.rightAnchor,
                                            paddingLeft: 20,
                                            paddingBottom: 15,
                                            paddingRight: 20)
        
        goToDeliveryAddressVCLabel.anchor(top: animationView.bottomAnchor,
                                          left: view.leftAnchor,
                                          bottom: nil,
                                          right: view.rightAnchor,
                                          paddingTop: 15,
                                          paddingLeft: 20,
                                          paddingRight: 20)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleGoToDeliveryAddressVC))
        goToDeliveryAddressVCLabel.addGestureRecognizer(tap)
        
        
        //Other Fields
        
        //cover image
        let coverImageDim = view.frame.size.width/3
        productCoverImageView.anchor(top: pageTitleLabel.bottomAnchor,
                                     left: view.leftAnchor,
                                     bottom: nil,
                                     right: nil,
                                     paddingTop: 25,
                                     paddingLeft: 15)
        productCoverImageView.setDimensions(height: coverImageDim, width: coverImageDim)
        
        //title label
        productTitleLabel.anchor(top: productCoverImageView.topAnchor,
                                 left: productCoverImageView.rightAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingLeft: 8,
                                 paddingRight: 15)
        
        productPriceLabel.anchor(top: productTitleLabel.bottomAnchor,
                                 left: productTitleLabel.leftAnchor,
                                 bottom: nil,
                                 right: productTitleLabel.rightAnchor,
                                 paddingTop: 8)
        
        //address title label
        addressTitleLabel.anchor(top: productCoverImageView.bottomAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingTop: 15,
                                 paddingLeft: 15,
                                 paddingBottom: 0,
                                 paddingRight: 15)
        
        editAddressButton.centerY(inView: addressTitleLabel)
        editAddressButton.anchor(right: view.rightAnchor,
                                 paddingRight: 15)
        
        
        addressStack.anchor(top: addressTitleLabel.bottomAnchor,
                            left: view.leftAnchor,
                            bottom: nil,
                            right: view.rightAnchor,
                            paddingTop: 15,
                            paddingLeft: 15,
                            paddingBottom: 0,
                            paddingRight: 15)
        
        confirmOrderButton.anchor(top: nil,
                                  left: view.leftAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.rightAnchor,
                                  paddingLeft: 15,
                                  paddingBottom: 15,
                                  paddingRight: 15)
        setupShadowToButton(button: confirmOrderButton)
        
        otherDetailsLabel.anchor(top: nil,
                                 left: view.leftAnchor,
                                 bottom: confirmOrderButton.topAnchor,
                                 right: view.rightAnchor,
                                 paddingLeft: 15,
                                 paddingBottom: 20,
                                 paddingRight: 15)
        
        
    }
    
    
}



//MARK: - API
extension ConfirmPurchaseVC {
    
    
    /// Checks if delivery address is filled
    private func fetchDeliveryAddress() {
        let uid = DatabaseManager.getCurrentUid()
        DatabaseManager.shared.fetchDeliveryAddress(with: uid, completion: { deliverAddress in
            self.deliveryAddress = deliverAddress
            
            //unwrap address
            guard let addressLineOne = deliverAddress.addressLineOne, !addressLineOne.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  let addressLineTwo = deliverAddress.addressLineTwo,
                  let country = deliverAddress.country,
                  let aptOrHouseNumber = deliverAddress.apartmentOrHouseNumber, !aptOrHouseNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  let city = deliverAddress.city, !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  let state = deliverAddress.state, !state.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  let streetNumber = deliverAddress.streetNumber, !streetNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  let zipCode = deliverAddress.zipCode, !zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
            {
                //show go to deliver address screen button
                self.refreshButton.isHidden = false
                self.goToDeliveryAddressVCLabel.isHidden = false
                self.notUpdatedAddressFieldsLabel.isHidden = false
                self.animationView.isHidden = false
                self.animationView.play()
                //hide everything else
                self.productCoverImageView.isHidden = true
                self.productTitleLabel.isHidden = true
                self.productPriceLabel.isHidden = true
                self.addressTitleLabel.isHidden = true
                self.addressStack.isHidden = true
                self.confirmOrderButton.isHidden = true
                self.otherDetailsLabel.isHidden = true
                self.editAddressButton.isHidden = true
                return
            }
            
            //hide other
            self.refreshButton.isHidden = true
            self.goToDeliveryAddressVCLabel.isHidden = true
            self.notUpdatedAddressFieldsLabel.isHidden = true
            self.animationView.isHidden = true
            //show product details
            self.productCoverImageView.isHidden = false
            self.productTitleLabel.isHidden = false
            self.productPriceLabel.isHidden = false
            self.addressTitleLabel.isHidden = false
            self.addressStack.isHidden = false
            self.confirmOrderButton.isHidden = false
            self.otherDetailsLabel.isHidden = false
            self.editAddressButton.isHidden = false
            //Set every address label
            
            self.lineOneLabel.text = "Address Line 1: \(addressLineOne)"
            self.lineTwoLabel.text = "Address Line 2: \(addressLineTwo)"
            self.apartmentHouseOrNumber.text = "🏠 : \(aptOrHouseNumber)"
            self.streetNumberORNameLabel.text = "Street Name/Number: \(streetNumber)"
            self.countryLabel.text = "Coutry: \(country)"
            self.stateLabel.text = "State: \(state)"
            self.cityLabel.text = "City: \(city)"
            self.zipCodeLabel.text = "ZipCode: \(zipCode)"
        })
    }
    
    
    
    
    /// Sets Up Basic Details of the product
    private func setupProductDetails() {
        guard let product = self.product else { return }
        guard let title = product.productName,
              let price = product.productPrice,
              let coverImageURL = product.coverImageURL else { return }
        
        let url = URL(string: coverImageURL)
        productTitleLabel.text = title
        productPriceLabel.text = price
        productCoverImageView.sd_setImage(with: url, completed: nil)
    }
    
    
    
    
    
    
    
    /// Confirms Orders
    private func confirmOrder() {
        print("DEBUG: Place Order Here")
        let buyerID = DatabaseManager.getCurrentUid()
        guard let productID = product?.productID,
              let productName = product?.productName,
              let sellerID = product?.ownerID else { return }
        DatabaseManager.shared.placeOrder(productID: productID,
                                          sellerID: sellerID, buyerID: buyerID,
                                          type: NOTIFICATION_MODEL.Purchased, completion: { done in
            if done {
                print("DEBUG: Order was Placed Successfully")
                let popUp = CustomPopUp(popupTitle: "PURCHASED", popupSubtitle: "Your Order for \(productName) was placed successfully. Continue Shopping?", customImage: #imageLiteral(resourceName: "icons8-grinning-face-with-big-eyes-48"))
                self.view.addSubview(popUp)
                self.navigationController?.removeViewController(HomeVC.self)
                self.resetPages()
            } else {
                print("DEBUG: Failed to Place Order")
                let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: "Something went wrong while placing order. Please try again.", customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                self.view.addSubview(popUp)
            }
        })
    }
    
    
    
    
    
    
    
    /// Resets Everything
    private func resetPages() {
        //show go home button
        goToHomeScreenButton.isHidden = false
        
        //hide everything else
        backButton.isHidden = true
        refreshButton.isHidden = true
        pageTitleLabel.isHidden = true
        animationView.isHidden = true
        notUpdatedAddressFieldsLabel.isHidden = true
        goToDeliveryAddressVCLabel.isHidden = true
        productCoverImageView.isHidden = true
        productTitleLabel.isHidden = true
        productPriceLabel.isHidden = true
        addressTitleLabel.isHidden = true
        addressStack.isHidden = true
        confirmOrderButton.isHidden = true
        otherDetailsLabel.isHidden = true
        editAddressButton.isHidden = true
    }
    
    
    
    
    
    
}
