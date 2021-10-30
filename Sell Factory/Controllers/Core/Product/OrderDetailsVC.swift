//
//  OrderDetailsVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/8/21.
//

import UIKit
import Firebase
import SDWebImage


class OrderDetailsVC: UIViewController {
    
    //MARK: - Properties
    var user: User?
    var product: Product?
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setHeight(height: 1.5)
        return view
    }()
    
    
    private let usernameLabel = SFLabel(texxt: "",
                                        fontName: Font.menloBold,
                                        fontSize: 25,
                                        noOfLines: 1,
                                        texxtColor: .label,
                                        texxtAlignment: .center)
    
    private let productCoverImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = CONST.CORNER_RADII
        iv.layer.borderWidth = 1.2
        iv.layer.borderColor = COLORS.customLavender.cgColor
        return iv
    }()
    
    
    private let productNameLabel = SFLabel(texxt: "",
                                           fontName: Font.menlo,
                                           fontSize: 14,
                                           noOfLines: 0,
                                           texxtColor: .label,
                                           texxtAlignment: .left)
    
    
    private let messageSellerButton: SFButton = {
        let button = SFButton(placeHolder: "✉️ Send Message")
        button.addTarget(self, action: #selector(handleMessageSellerTap), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    //MARK: - Lifecycle
    init(user: User, product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.product = product
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupUserDetails()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
    }
    
    
    
    
    
    
    
    
    /// Configures the views of this view ontroller
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(profileImageView)
        view.addSubview(separatorView)
        view.addSubview(usernameLabel)
        view.addSubview(productCoverImage)
        view.addSubview(productNameLabel)
        view.addSubview(messageSellerButton)
        
        //layout views
        profileImageView.anchor(top: view.topAnchor,
                                left: view.leftAnchor,
                                bottom: nil,
                                right: view.rightAnchor)
        profileImageView.setDimensions(height: view.frame.size.width, width: view.frame.size.width)
        
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: profileImageView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingLeft: 15)
        view.bringSubviewToFront(backButton)
        
        separatorView.anchor(top: profileImageView.bottomAnchor,
                             left: profileImageView.leftAnchor,
                             bottom: nil,
                             right: profileImageView.rightAnchor)
        
        
        usernameLabel.centerY(inView: separatorView)
        usernameLabel.centerX(inView: separatorView)
        usernameLabel.textDropShadow()
        
        productCoverImage.anchor(top: usernameLabel.bottomAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: nil,
                                 paddingTop: 25,
                                 paddingLeft: 15)
        productCoverImage.setDimensions(height: 150, width: 150)
        
        productNameLabel.centerY(inView: productCoverImage)
        productNameLabel.anchor(left: productCoverImage.rightAnchor,
                                right: view.rightAnchor,
                                paddingLeft: 10,
                                paddingRight: 15)
        
        
        
        messageSellerButton.anchor(top: nil,
                                   left: view.leftAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   right: view.rightAnchor,
                                   paddingLeft: 15,
                                   paddingRight: 15)
        
        
    }
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    /// Handles Message Seller Tap
    @objc private func handleMessageSellerTap() {
        generateFeedback()
        print("DEBUG: Send Message to Seller Here")
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        guard let user = self.user,
              let uid = user.currenUid else { return }
        
        if currentUID != uid {
            let vc = ChatController(user: user)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            return
        }
        
    }
    
    
    
    
    
}
//MARK: - Extensions

//MARK: - API
extension OrderDetailsVC {
    
    
    /// Sets up the basic user details
    private func setupUserDetails() {
        guard let user = self.user else { return }
        guard let product = self.product else { return }
        
        guard let profileImageURL = user.profileImageURL,
              let fn = user.firstName,
              let ln = user.lastName else { return }
        guard let coverImageURL = product.coverImageURL,
              let productName = product.productName else { return }
        
        let pURL = URL(string: profileImageURL)
        let cURL = URL(string: coverImageURL)
        
        profileImageView.sd_setImage(with: pURL, completed: nil)
        productCoverImage.sd_setImage(with: cURL, completed: nil)
        
        usernameLabel.text = "\(fn) \(ln)"
        productNameLabel.text = "1x \(productName)"
    }
    
}
