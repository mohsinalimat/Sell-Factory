//
//  HomeVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import UIKit
import Firebase
import SDWebImage


class HomeVC: UIViewController {
    
    //MARK: - Properties
    
    var currentKey: String?
    var categoryKey: String?
    
    var isListView = false
    var user: User?
    var product = [Product]()
    var filteredProduct = [Product]()
    var inSearchMode = false
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TXT.APP_TITLE
        label.font = UIFont(name: Font.menloBold, size: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let searchBarTF: SFTextField = {
        let tf = SFTextField(placeHolder: TXT.SEARCH, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 30)
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private let profileImageView = SFImageView(bgColor: .secondarySystemBackground,
                                               contentmode: .scaleAspectFit,
                                               clipsTobounds: true, isInteractable: true, dim: 30)
    
    private let listOrGridImageView: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: false, isInteractable: true, dim: 30)
        iv.tintColor = .label
        iv.image = UIImage(systemName: SFSYMBOLS.LIST)
        return iv
    }()
    

    
    //MARK: - Category Buttons
    
    //All Category
    private let allProductItemsButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.ALL)
        button.addTarget(self, action: #selector(allProductsCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    
    //Electronics Button
    private let electronicsItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.ELECTRONICS)
        button.addTarget(self, action: #selector(electronicsCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Home Items
    private let homeItemsButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.HOME)
        button.addTarget(self, action: #selector(homeCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Garden Items
    private let gardenItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.GARDEN)
        button.addTarget(self, action: #selector(gardenCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Craft Items
    private let craftItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.CRAFT)
        button.addTarget(self, action: #selector(craftCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Furniture
    private let furnitureItemsButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.FURNITURE)
        button.addTarget(self, action: #selector(furnitureCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Pet Supplies Button
    private let petItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.PET)
        button.addTarget(self, action: #selector(petSuppliesCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Clothing Item
    private let clothingItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.CLOTHES)
        button.addTarget(self, action: #selector(clothingCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    
    //Food and Grocery
    private let foodAndGroceryItemsButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.FOOD)
        button.addTarget(self, action: #selector(foodCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Toy
    private let toyItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.TOY)
        button.addTarget(self, action: #selector(toysCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Handmade
    private let handmadeItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.HANDMADE)
        button.addTarget(self, action: #selector(handmadeCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Sport Items
    private let sportItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.SPORTS)
        button.addTarget(self, action: #selector(sportsCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Tools
    private let toolsItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.TOOLS)
        button.addTarget(self, action: #selector(toolsCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    //Other
    private let otherItemButton: SFCategoryButton = {
        let button = SFCategoryButton(placeHolder: CATEGORY.OTHERS)
        button.addTarget(self, action: #selector(otherCategoryTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let categoryStack = SFStackView(stackAxis: .horizontal, stackSpace: 10)
    private let categoryScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private let categoryScrollBackgroundView: UIView = {
        let view = UIView()
        return view
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
    
    
    private let messageButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.PAPER_AIRPLANE, color: .label)
        button.addTarget(self, action: #selector(handleMessageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let notificationsButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.NOTIFICATION, color: .label)
        button.addTarget(self, action: #selector(handleNotificationsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    
    /// Sets up the basic ui of this view controller
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
        fetchUserData()
        
        //remove from navigation stack
        navigationController?.removeViewController(LoginVC.self)
        navigationController?.removeViewController(RegisterVC.self)
        navigationController?.removeViewController(ConfirmPurchaseVC.self)
        
        fetchProducts()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    /// Goes to Profile View Controller
    @objc private func handleProfileImageTapped() {
        generateFeedback()
        guard let profileImage = profileImageView.image else { return }
        guard let user = self.user else { return }
        let vc = ProfileVC(image: profileImage, user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    /// Handle List or Grid Image Tap
    @objc private func handleListOrGridImageTap() {
        generateFeedback()
        if isListView {
            listOrGridImageView.image = UIImage(systemName: SFSYMBOLS.LIST)
            isListView = false
        } else {
            listOrGridImageView.image = UIImage(systemName: SFSYMBOLS.GRID)
            isListView = true
        }
        productsCollectionView.reloadData()
    }
    
    
    
    
    
    /// Filters Products based on their Name
    /// - Parameter textField: UITextField
    @objc func textFieldDidChange(_ textField: UITextField) {
        let searchText = textField.text?.lowercased()
        if searchText!.isEmpty || searchText == " " {
            inSearchMode = false
            productsCollectionView.reloadData()
        } else {
            inSearchMode = true
            filteredProduct = product.filter({ product in
                return product.productName.lowercased().contains(searchText!)
            })
            productsCollectionView.reloadData()
        }
    }
      
    
    
    
    /// Handles Notification Button Tap
    @objc private func handleNotificationsButtonTapped() {
        generateFeedback()
        print("DEBUG: Go To Notifications Page")
        navigationController?.pushViewController(NotificationsVC(), animated: true)
    }
    
    
    
    
    
    
    /// Handles Message button tap
    @objc private func handleMessageButtonTapped() {
        generateFeedback()
        print("DEBUG: Go to Messages Page")
        navigationController?.pushViewController(MessagesVC(), animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

//MARK: - Extensions

//MARK: - TextField Delegate
extension HomeVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}






//MARK: - Configure View Extension
extension HomeVC {
    
    
    
    /// Configures Views of this View Controller
    private func configureViews() {
        //add sub views
        view.addSubview(titleLabel)
        view.addSubview(searchBarTF)
        view.addSubview(profileImageView)
        view.addSubview(productsCollectionView)
        view.addSubview(listOrGridImageView)
        view.addSubview(messageButton)
        view.addSubview(notificationsButton)
        
        
        //layout views
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        
        notificationsButton.centerY(inView: titleLabel)
        notificationsButton.anchor(left: view.leftAnchor,
                                   paddingLeft: 15)
        
        messageButton.centerY(inView: titleLabel)
        messageButton.anchor(right: view.rightAnchor,
                             paddingRight: 15)
        
        
        //setupShadowToTextField(textField: searchBarTF)
        searchBarTF.delegate = self
        searchBarTF.anchor(top: titleLabel.bottomAnchor,
                           left: view.leftAnchor,
                           bottom: nil,
                           right: listOrGridImageView.leftAnchor,
                           paddingTop: 10,
                           paddingLeft: 15,
                           paddingRight: 8)
        searchBarTF.setHeight(height: 30)
        
        
        listOrGridImageView.centerY(inView: profileImageView)
        listOrGridImageView.anchor(top: titleLabel.bottomAnchor,
                                   right: profileImageView.leftAnchor,
                                   paddingTop: 10,
                                   paddingRight: 8)
        let listTap = UITapGestureRecognizer(target: self, action: #selector(handleListOrGridImageTap))
        listOrGridImageView.addGestureRecognizer(listTap)
        
        profileImageView.anchor(top: titleLabel.bottomAnchor,
                             left: nil,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 15)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.layer.borderColor = COLORS.customLavender.cgColor
        profileImageView.layer.borderWidth = 1.2
        
        
        //category section
        view.addSubview(categoryScrollBackgroundView)
        categoryScrollBackgroundView.setHeight(height: CONST.BUTTON_HEIGHT)
        categoryScrollBackgroundView.anchor(top: searchBarTF.bottomAnchor,
                                            left: view.leftAnchor,
                                            bottom: nil,
                                            right: view.rightAnchor,
                                            paddingTop: 15,
                                            paddingLeft: 10,
                                            paddingRight: 10)
        
        
        categoryScrollBackgroundView.addSubview(categoryScrollView)
        categoryScrollView.anchor(top: categoryScrollBackgroundView.topAnchor,
                                  left: categoryScrollBackgroundView.leftAnchor,
                                  bottom: categoryScrollBackgroundView.bottomAnchor,
                                  right: categoryScrollBackgroundView.rightAnchor)

        categoryScrollView.addSubview(categoryStack)
        categoryStack.anchor(top: categoryScrollView.topAnchor,
                                  left: categoryScrollView.leftAnchor,
                                  bottom: categoryScrollView.bottomAnchor,
                                  right: categoryScrollView.rightAnchor)

        categoryStack.addArrangedSubview(allProductItemsButton)
        categoryStack.addArrangedSubview(electronicsItemButton)
        categoryStack.addArrangedSubview(homeItemsButton)
        categoryStack.addArrangedSubview(gardenItemButton)
        categoryStack.addArrangedSubview(craftItemButton)
        categoryStack.addArrangedSubview(furnitureItemsButton)
        categoryStack.addArrangedSubview(petItemButton)
        categoryStack.addArrangedSubview(clothingItemButton)
        categoryStack.addArrangedSubview(foodAndGroceryItemsButton)
        categoryStack.addArrangedSubview(toyItemButton)
        categoryStack.addArrangedSubview(handmadeItemButton)
        categoryStack.addArrangedSubview(sportItemButton)
        categoryStack.addArrangedSubview(toolsItemButton)
        categoryStack.addArrangedSubview(otherItemButton)
        
        
        //products collection view
        productsCollectionView.anchor(top: categoryScrollBackgroundView.bottomAnchor,
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




//MARK: - Collection View Delegate & Data Source
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if product.count > 5 {
            if indexPath.item == product.count-1 {
                fetchProducts()
            }
        }
    }
    
    
    
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
    

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredProduct.count
        } else {
            return product.count
        }
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
            
            var products: Product!
            if inSearchMode {
                products = filteredProduct[indexPath.row]
            } else {
                products = product[indexPath.row]
            }
            
            cell.product = products
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
            
            var products: Product!
            if inSearchMode {
                products = filteredProduct[indexPath.row]
            } else {
                products = product[indexPath.row]
            }
            cell.product = products
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        generateFeedback()
        var products: Product!
        if inSearchMode {
            products = filteredProduct[indexPath.row]
        } else {
            products = product[indexPath.row]
        }
        let vc = ProductDetailsVC(product: products)
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - API
extension HomeVC {
    
    
    
    /// Fetches Data of Current Logged In User
    private func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_REF.child(currentUid).observe(.value, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {
                return
            }
            let userId = snapshot.key
            let user = User(uid: userId, dictionary: dictionary)
            self.user = user
            guard let profileImageURL = user.profileImageURL else { return }
            let profileImage = URL(string: profileImageURL)
            self.profileImageView.sd_setImage(with: profileImage, completed: nil)
        })
    }
    
    
    
    
    
    /// Fetches Products from Firebase
    private func fetchProducts() {
        if currentKey == nil {
            //initial data pull
            PRODUCTS_REF.queryLimited(toLast: 6).observeSingleEvent(of: .value, with: { snapshot in
                guard let first = snapshot.children.allObjects.first as? DataSnapshot else { return }
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach({ snapshot in
                    let productID = snapshot.key
                    DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                        self.product.append(product)
                        self.product.sort { product1, product2 in
                            return product1.creationDate > product2.creationDate
                        }
                        self.productsCollectionView.reloadData()
                    })
                })
                self.currentKey = first.key
            })
        } else {
            //paginate here
            PRODUCTS_REF.queryOrderedByKey().queryEnding(atValue: self.currentKey).queryLimited(toLast: 5).observeSingleEvent(of: .value, with: { snapshot in
                guard let first = snapshot.children.allObjects.first as? DataSnapshot else { return }
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach({ snapshot in
                    let productID = snapshot.key
                    if productID != self.currentKey {
                        DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                            self.product.append(product)
                            self.product.sort { product1, product2 in
                                return product1.creationDate > product2.creationDate
                            }
                            self.productsCollectionView.reloadData()
                        })
                    }
                })
                self.currentKey = first.key
            })
        }
    }
    
    
    
    
    
    
    
    
    /// Fetches Products From Specific Category
    /// - Parameter category: String
    private func fetchCategoryProducts(category: String) {
        product.removeAll()
        DB_REF.child(category).observe(.childAdded, with: { snapshot in
            let productID = snapshot.key
            DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                self.product.append(product)
                self.product.sort { product1, product2 in
                    return product1.creationDate > product2.creationDate
                }
                self.productsCollectionView.reloadData()
            })
        })
    }
    
    

    
}







//MARK: - Category Button Extensions
extension HomeVC {
    
    
    
    
    /// All Category Button Tapped
    @objc private func allProductsCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.ALL) Tapped")
        fetchCategoryProducts(category: CATEGORY.ALL_PRODUCTS)
    }
    
    
    
    
    /// Electronics Button Tapped
    @objc private func electronicsCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.ELECTRONICS) Tapped")
        fetchCategoryProducts(category: CATEGORY.ELECTRONICS)
    }
    
    
    
    /// Home Button Tapped
    @objc private func homeCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.HOME) Tapped")
        fetchCategoryProducts(category: CATEGORY.HOME)
    }
    
    
    
    /// Garden Button Tapped
    @objc private func gardenCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.GARDEN) Tapped")
        fetchCategoryProducts(category: CATEGORY.GARDEN)
    }
    
    
    
    
    
    /// Craft Button Tapped
    @objc private func craftCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.CRAFT) Tapped")
        fetchCategoryProducts(category: CATEGORY.CRAFT)
    }
    
    
    
    
    /// Furniture Button Tapped
    @objc private func furnitureCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.FURNITURE) Tapped")
        fetchCategoryProducts(category: CATEGORY.FURNITURE)
    }
    
    
    
    
    
    
    /// Pet Supplies Button Tapped
    @objc private func petSuppliesCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.PET) Tapped")
        fetchCategoryProducts(category: CATEGORY.PET)
    }
    
    
    
    
    /// Clothing Button Tapped
    @objc private func clothingCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.CLOTHES) Tapped")
        fetchCategoryProducts(category: CATEGORY.CLOTHES)
    }
    
    
    
    
    /// Food and Grocery Button Tapped
    @objc private func foodCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.FOOD) Tapped")
        fetchCategoryProducts(category: CATEGORY.FOOD)
    }
    
    
    
    
    
    /// Toys Button Tapped
    @objc private func toysCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.TOY) Tapped")
        fetchCategoryProducts(category: CATEGORY.TOY)
    }
    
    
    
    
    
    /// Handmade Button Tapped
    @objc private func handmadeCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.HANDMADE) Tapped")
        fetchCategoryProducts(category: CATEGORY.HANDMADE)
    }
    
    
    
    /// Sports Button Tapped
    @objc private func sportsCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.SPORTS) Tapped")
        fetchCategoryProducts(category: CATEGORY.SPORTS)
    }
    
    
    
    
    /// Tools Button Tapped
    @objc private func toolsCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.TOOLS) Tapped")
        fetchCategoryProducts(category: CATEGORY.TOOLS)
    }
    
    
    
    
    /// Others Button Tapped
    @objc private func otherCategoryTapped() {
        generateFeedback()
        print("DEBUG: \(CATEGORY.OTHERS) Tapped")
        fetchCategoryProducts(category: CATEGORY.OTHERS)
    }
    
    
    
}

