//
//  ProfileVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit
import Firebase
import SDWebImage


class ProfileVC: UIViewController {
    
    //MARK: - Properties
    var isListView = false
    
    var product = [Product]()
    var user: User?
    var profileImage: UIImage?
    
    //For Bottom Sheet
    var transparentView = UIView()
    lazy var bottomSheetTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.register(ProfileSettingsMenuCell.self, forCellReuseIdentifier: ProfileSettingsMenuCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        tv.layer.cornerRadius = 20
        tv.layer.borderWidth = 2
        tv.layer.borderColor = COLORS.customLavender.cgColor
        return tv
    }()
    var settingsArray = [SETTINGS_MENU.EDITPROFILE,
                         SETTINGS_MENU.MESSAGES,
                         SETTINGS_MENU.NOTIFICATIONS,
                         SETTINGS_MENU.SETTINGS,
                         SETTINGS_MENU.YOUR_ORDERS,
                         SETTINGS_MENU.SAVED,SETTINGS_MENU.LOGOUT]
    var settingsImagesArray = [UIImage(systemName: SFSYMBOLS.PERSON_CIRCLE),
                               UIImage(systemName: SFSYMBOLS.MESSAGE),
                               UIImage(systemName: SFSYMBOLS.NOTIFICATION),
                               UIImage(systemName: SFSYMBOLS.SETTINGS),
                               UIImage(systemName: SFSYMBOLS.CART),
                               UIImage(systemName: SFSYMBOLS.SAVED),
                               UIImage(systemName: SFSYMBOLS.LOGOUT)]
    
    
    
    
    
    //Other Variables
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let postButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.POST, color: .label)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    
    private let settingsButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.SETTINGS, color: .label)
        button.addTarget(self, action: #selector(handleSettingsTapped), for: .touchUpInside)
        return button
    }()
    
    private let listOrGridButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.LIST, color: .label)
        button.addTarget(self, action: #selector(handleListOrGridImageTap), for: .touchUpInside)
        return button
    }()

   private let editProfileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: SFSYMBOLS.PLUS_IMAGE)
        iv.tintColor = COLORS.customLavender
        iv.setDimensions(height: 25, width: 25)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let profileImageView = SFImageView(bgColor: .secondaryLabel,
                                               contentmode: .scaleAspectFit,
                                               clipsTobounds: true,
                                               isInteractable: true,
                                               dim: 70)
    
    private let nameLabel = SFLabel(texxt: "Pranav Badgi",
                                    fontName: Font.menloBold,
                                    fontSize: 18,
                                    noOfLines: 1,
                                    texxtColor: .label,
                                    texxtAlignment: .left)
    
    private let usernameLabel = SFLabel(texxt: "@pranav",
                                        fontName: Font.menlo,
                                        fontSize: 16,
                                        noOfLines: 1,
                                        texxtColor: .label,
                                        texxtAlignment: .left)
    
    
    private let yourProductsLabel = SFLabel(texxt: "Your Products",
                                        fontName: Font.menlo,
                                        fontSize: 16,
                                        noOfLines: 1,
                                        texxtColor: .label,
                                        texxtAlignment: .center)
    
    
    private let bioLabel = SFLabel(texxt: "New to this platform. Looking to sell some products!",
                                   fontName: Font.menlo,
                                   fontSize: 14,
                                   noOfLines: 0,
                                   texxtColor: .label,
                                   texxtAlignment: .justified)
    
    
    private let locationLabel = SFCategoryButton(placeHolder: CATEGORY.LOCATION)
    
    private let ordersButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.ORDERS)
        button.addTarget(self, action: #selector(handleOrderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    

    //Products Collection View
    private let productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.identifier)
        collectionView.register(ProductsGridViewCell.self, forCellWithReuseIdentifier: ProductsGridViewCell.identifier)
        return collectionView
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    init(image: UIImage, user: User) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
        self.profileImage = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Configures Basic UI of the View Controller
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
        fetchUserData()
        fetchUserProducts()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    /// Handles Edit Profile Tap
    @objc private func handleEditProfileTapped() {
        generateFeedback()
        print("DEBUG: Go To Edit Profile Here")
    }
    
    
    
    /// Handles Post Product Tap
    @objc private func handlePostTapped() {
        generateFeedback()
        print("DEBUG: Go To Post Product Page here")
        navigationController?.pushViewController(PostProductVC(), animated: true)
    }
    
    
    
    
    /// Handles Settings Tap
    @objc private func handleSettingsTapped() {
        generateFeedback()
        print("DEBUG: Go To Settings View Controller here")
        showBottomSheet()
    }
    
    
    
    
    
    /// Handles order button tap. shows orders for the current user
    @objc private func handleOrderButtonTapped() {
        generateFeedback()
        print("DEBUG: Show order for this user")
        navigationController?.pushViewController(YourOrdersVC(), animated: true)
    }
    
    
    
    
    
    /// Handles Profile Image Tap Gesture
    @objc private func handleProfileImageTapped() {
        generateFeedback()
        print("DEBUG: Handle Profile Image Tap Here")
        guard let image = profileImageView.image else { return }
        guard let name = user?.firstName else { return }
        let vc = ViewImageVC(vcPicture: image, vcTitle: name)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    /// Handle List or Grid Image Tap
    @objc private func handleListOrGridImageTap() {
        generateFeedback()
        if isListView {
            listOrGridButton.setImage(UIImage(systemName: SFSYMBOLS.LIST), for: .normal)
            isListView = false
        } else {
            listOrGridButton.setImage(UIImage(systemName: SFSYMBOLS.GRID), for: .normal)
            isListView = true
        }
        productsCollectionView.reloadData()
    }

    
    
    
    
    
    
    
    
    
}
//MARK: - Extension


//ARK: - Configure View Extension
extension ProfileVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(postButton)
        view.addSubview(settingsButton)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        view.addSubview(editProfileImageView)
        view.addSubview(locationLabel)
        view.addSubview(ordersButton)
        view.addSubview(productsCollectionView)
        view.addSubview(yourProductsLabel)
        view.addSubview(listOrGridButton)
        
        //layout views
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingLeft: 15)
        
        settingsButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: nil,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingRight: 15)
        
        postButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: nil,
                          bottom: nil,
                          right: settingsButton.leftAnchor,
                          paddingRight: 8)
        
        listOrGridButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: postButton.leftAnchor,
                                paddingRight: 8)
        
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = COLORS.customLavender.cgColor
        profileImageView.anchor(top: backButton.bottomAnchor,
                                left: view.leftAnchor,
                                paddingTop: 15,
                                paddingLeft: 15)
        editProfileImageView.anchor(top: nil,
                                    left: nil,
                                    bottom: profileImageView.bottomAnchor,
                                    right: profileImageView.rightAnchor)
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(profileImageTap)
        
        
        
        nameLabel.anchor(top: profileImageView.topAnchor,
                         left: profileImageView.rightAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         paddingTop: 5,
                         paddingLeft: 10,
                         paddingRight: 15)
        usernameLabel.anchor(top: nameLabel.bottomAnchor,
                             left: profileImageView.rightAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 5,
                             paddingLeft: 10,
                             paddingRight: 15)
        bioLabel.anchor(top: profileImageView.bottomAnchor,
                        left: view.leftAnchor,
                        bottom: nil,
                        right: view.rightAnchor,
                        paddingTop: 10,
                        paddingLeft: 15,
                        paddingRight: 15)
        
        locationLabel.anchor(top: bioLabel.bottomAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: nil,
                             paddingTop: 8,
                             paddingLeft: 15)
        
        ordersButton.anchor(top: bioLabel.bottomAnchor,
                            left: locationLabel.rightAnchor,
                            bottom: nil,
                            right: nil,
                            paddingTop: 8,
                            paddingLeft: 8)
        
        yourProductsLabel.anchor(top: locationLabel.bottomAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingTop: 10,
                                 paddingLeft: 15,
                                 paddingBottom: 0,
                                 paddingRight: 15)
        
        productsCollectionView.anchor(top: yourProductsLabel.bottomAnchor,
                                      left: view.leftAnchor,
                                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                      right: view.rightAnchor,
                                      paddingTop: 8,
                                      paddingLeft: 5,
                                      paddingRight: 5)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
    }
    
}

















//MARK: - Bottom Sheet Extensions
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    
    //TABLE VIEW DELEGATES & DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bottomSheetTableView.dequeueReusableCell(withIdentifier: ProfileSettingsMenuCell.identifier, for: indexPath) as! ProfileSettingsMenuCell
        cell.leftLabel.text = settingsArray[indexPath.row]
        cell.leftImageView.image = settingsImagesArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClickTransparentView()
        switch indexPath.row {
        case 0:
            generateFeedback()
            guard let user = self.user else { return }
            guard let image = profileImageView.image else { return }
            let vc = EditProfileVC(image: image, user: user)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            generateFeedback()
            navigationController?.pushViewController(MessagesVC(), animated: true)
        case 2:
            generateFeedback()
            navigationController?.pushViewController(NotificationsVC(), animated: true)
        case 3:
            generateFeedback()
            navigationController?.pushViewController(SettingsVC(), animated: true)
        case 4:
            generateFeedback()
            navigationController?.pushViewController(YourOrdersVC(), animated: true)
        case 5:
            generateFeedback()
            navigationController?.pushViewController(SavedVC(), animated: true)
        case 6:
            generateFeedback()
            print("DEBUG: Handle Logout Here")
            handleSignOut()
        default:
            print("DEBUG: No VC Here")
            break
        }
    }
    
    
    
    
    
    
    /// Animates the Bottom Sheet in the View Controller
    private func showBottomSheet() {
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = view.frame
        view.addSubview(transparentView)
        //table view
        let screenSize = UIScreen.main.bounds.size
        bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 360)
        //height = 250 because 5 cells of size 50
        view.addSubview(bottomSheetTableView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        //Animate in the tableview
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height-360, width: screenSize.width, height: 360)
        }, completion: nil)
    }
    
    
    
    
    
    /// Selectors of Transparent View Tap Gesture, Animates out the View and Table View
    @objc private func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        //Animate the tableview out of screen
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.generateFeedback()
            self.transparentView.alpha = 0
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 360)
        }, completion: nil)
    }
    
    
    
}


//MARK: - Collection View Delegate & Data Source
extension ProfileVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((view.frame.width)/2)-6
        let listViewWidth = (view.frame.width)-20
        
        if isListView {
            return CGSize(width: listViewWidth, height: listViewWidth-190)
        } else {
            return CGSize(width: width, height: (width+50)-6)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.identifier, for: indexPath) as! ProductsCell
            cell.backgroundColor = .clear
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            cell.layer.borderWidth = 1.2
            cell.layer.borderColor = COLORS.customLavender.cgColor
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 10.0
            cell.layer.masksToBounds = false
            
            cell.product = product[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsGridViewCell.identifier, for: indexPath) as! ProductsGridViewCell
            cell.backgroundColor = .clear
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            cell.layer.borderWidth = 1.2
            cell.layer.borderColor = COLORS.customLavender.cgColor
            
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 10.0
            cell.layer.masksToBounds = false
            
            cell.product = product[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        generateFeedback()
        print("DEBUG: Index: \(indexPath.row)")
        let product = product[indexPath.row]
        let vc = ProductDetailsVC(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK: - API
extension ProfileVC {
    
    
    
    /// Fetches User data and sets labels and other things
    private func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.currenUid else { return }
        
        if currentUid != userId {
            print("DEBUG: Different User is Logged In")
            //unwrap data and add to labels
            guard let fn = user?.firstName,
                  let ln = user?.lastName,
                  let bio = user?.bio,
                  let country = user?.country else { return }
            
            //hide buttons
            postButton.isHidden = true
            settingsButton.isHidden = true
            ordersButton.isHidden = true
            //set labels
            usernameLabel.text = "@\(fn.lowercased())"
            nameLabel.text = "\(fn) \(ln)"
            bioLabel.text = bio
            locationLabel.setTitle("📍 \(country)", for: .normal)
            profileImageView.image = profileImage
            //fetch this users products
            print("DEBUG: Fetch This Users Products")
        } else {
            //same User
            USER_REF.child(currentUid).observe(.value, with: { snapshot in
                guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                let userId = snapshot.key
                let user = User(uid: userId, dictionary: dictionary)
                self.user = user
                
                //unwrap data and add to labels
                guard let fn = user.firstName,
                      let ln = user.lastName,
                      let bio = user.bio,
                      let country = user.country else { return }
                
                self.nameLabel.text = "\(fn) \(ln)"
                self.usernameLabel.text = "@\(fn.lowercased())"
                self.bioLabel.text = bio
                self.locationLabel.setTitle("📍 \(country)", for: .normal)
                guard let url = URL(string: user.profileImageURL) else { return }
                self.profileImageView.sd_setImage(with: url, completed: nil)
                
                if self.bioLabel.text?.trimmingCharacters(in: .whitespaces) == "" || country.trimmingCharacters(in: .whitespaces) == "" {
                    let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.BIO_COUNTRY_MISSING, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                    self.view.addSubview(popUp)
                }
            })
        }
    }
    
    
    
    
    
    
    /// Fetches Products of the Current User
    private func fetchUserProducts() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        CURRENT_USER_PRODUCTS_REF.child(currentUid).observe(.value, with: { snapshot in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ snapshot in
                let productID = snapshot.key
                DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                    self.product.append(product)
                    self.productsCollectionView.reloadData()
                })
            })
            
        })
    }
    
    
    
    
    
    
    /// Handles Signout
    private func handleSignOut() {
        popUpWithButtons(imgName: SFSYMBOLS.LOGOUT, btnYesText: "Yes", btnNoText: "No", yesButtonBGColor: .systemRed, noButtonBGColor: .systemGreen, viewBorderColor: COLORS.customLavender, txtMessage: "Are you Sure you Want To Logout?", numOfButtons: 2, completion: { yes in
            if yes {
                self.generateFeedback()
                DatabaseManager.shared.logoutCurrentUser(completion: { logout in
                    if logout {
                        //go to login screen
                        let vc = UINavigationController(rootViewController: LoginVC())
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.LOGOUT_ERROR, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                        self.view.addSubview(popUp)
                    }
                })
            } else {
                self.generateFeedback()
            }
        })
    }
    
    
    
    
    
}
