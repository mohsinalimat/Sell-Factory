//
//  ProductDetailsVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import UIKit
import Firebase


class ProductDetailsVC: UIViewController {
    
    //MARK: - Properties
    var product: Product?
    var isCurrentUserViewing = false
    private var models = [ProductImageModel]()
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let optionsMenu: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.DOT, color: .label)
        button.addTarget(self, action: #selector(handleOptionsButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let threeDotsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: SFSYMBOLS.ELLIPISE)
        image.tintColor = .secondaryLabel
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    
    
    private let pageTitleLabel = SFLabel(texxt: PRODUCT_DETAILS.TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    
    
    
    
    //product image collection view
    private let productImagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProductImageCell.self, forCellWithReuseIdentifier: ProductImageCell.identifier)
        return cv
    }()
    
    
    
    //scroll view and stack view
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    //product labels
    private let productNameLabel = SFLabel(texxt: "",
                                           fontName: Font.menloBold,
                                           fontSize: 24,
                                           noOfLines: 0,
                                           texxtColor: .label,
                                           texxtAlignment: .left)
    
    private let productDescriptionLabel = SFLabel(texxt: "",
                                           fontName: Font.menlo,
                                           fontSize: 16,
                                           noOfLines: 0,
                                           texxtColor: .secondaryLabel,
                                           texxtAlignment: .justified)
    
    
    
    private let priceTitleLabel = SFLabel(texxt: PRODUCT_DETAILS.PRICE,
                                          fontName: Font.menloBold,
                                          fontSize: 20,
                                          noOfLines: 0,
                                          texxtColor: .label,
                                          texxtAlignment: .left)
    
    private let priceLabel = SFLabel(texxt: "",
                                          fontName: Font.menloBold,
                                          fontSize: 24,
                                          noOfLines: 0,
                                          texxtColor: .label,
                                          texxtAlignment: .left)
    
    private let priceStack = SFStackView(stackAxis: .vertical, stackSpace: 8)
    
    
    private let inStockLabel = SFLabel(texxt: "",
                                       fontName: Font.menloBold,
                                       fontSize: 20,
                                       noOfLines: 0,
                                       texxtColor: .systemGreen,
                                       texxtAlignment: .left)
    
    private let productCategoryLabel = SFLabel(texxt: CATEGORY.HANDMADE,
                                          fontName: Font.menloBold,
                                          fontSize: 20,
                                          noOfLines: 0,
                                          texxtColor: .label,
                                          texxtAlignment: .right)
    
    private let internationalShippingAvailableLabel = SFLabel(texxt: "",
                                                              fontName: Font.menloBold,
                                                              fontSize: 16,
                                                              noOfLines: 0,
                                                              texxtColor: .secondaryLabel,
                                                              texxtAlignment: .justified)
    
    private let deliveryInNumberOfDaysLabel = SFLabel(texxt: "",
                                                      fontName: Font.menloBold,
                                                      fontSize: 16,
                                                      noOfLines: 0,
                                                      texxtColor: .label,
                                                      texxtAlignment: .left)
    
    
    private let soldByLabel = SFLabel(texxt: PRODUCT_DETAILS.SOLD_BY,
                                      fontName: Font.menlo,
                                      fontSize: 14, noOfLines: 1, texxtColor: .secondaryLabel, texxtAlignment: .right)
    
    private let sellerImageProfileView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = COLORS.customLavender
        image.setDimensions(height: 50, width: 50)
        image.layer.cornerRadius = 50/2
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    
    private let sellerStack = SFStackView(stackAxis: .horizontal, stackSpace: 8)
    
    private let buyNowButton: SFButton = {
        let button = SFButton(placeHolder: PRODUCT_DETAILS.BUY_NOW)
        button.addTarget(self, action: #selector(handleBuyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    //customizable
    private let customizableTitle: SFLabel = {
        let label = SFLabel(texxt: PRODUCT_DETAILS.CUSTOM_TITLE,
                            fontName: Font.menlo, fontSize: 16, noOfLines: 0, texxtColor: .secondaryLabel, texxtAlignment: .left)
        label.isHidden = true
        return label
    }()
    
    
    private let customizableTextField: SFTextField = {
        let tf = SFTextField(placeHolder: "Order Request", autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
        tf.isHidden = true
        return tf
    }()
    
    
    
    
    
    
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
    
    let currentUserOptionsArray = ["Edit Product","Delete Product"]
    let currentUserOptionsImages = [UIImage(systemName: SFSYMBOLS.EDIT),
                                    UIImage(systemName: SFSYMBOLS.DELETE)]
    
    let customerOptionsArray = ["Report Product","Save for Later"]
    let customerOptionsImages = [UIImage(systemName: SFSYMBOLS.CIRCLE_EXCLAMATION),
                                 UIImage(systemName: SFSYMBOLS.SAVED)]
    
    
    
    private let blankLabelOne = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    private let blankLabelTwo = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    private let blankLabelThree = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    private let blankLabelFour = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    
    private let blankLabelFive = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    private let blankLabelSix = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    private let blankLabelSeven = SFLabel(texxt: POST_PRODUCT_TEXTS.BLANK_SPACE,
                                        fontName: Font.menlo,
                                        fontSize: 14,
                                        noOfLines: 0,
                                        texxtColor: .secondaryLabel,
                                        texxtAlignment: .left)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
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
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
        configureProductDetails()
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    /// Handles Buy Button Tap
    @objc private func handleBuyButtonTapped() {
        generateFeedback()
        print("DEBUG: Handle Buy Button Tap")
        guard let product = self.product else { return }
        navigationController?.pushViewController(ConfirmPurchaseVC(product: product), animated: true)
    }

    
    
    
    /// Handles Option Button Tap
    @objc private func handleOptionsButtonTapped() {
        generateFeedback()
        print("DEBUG: Handle Options Button Tap")
        showBottomSheet()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extensions
extension ProductDetailsVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(optionsMenu)
        view.addSubview(pageTitleLabel)
        view.addSubview(scrollView)
        
        
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        optionsMenu.centerY(inView: pageTitleLabel)
        optionsMenu.anchor(right: view.rightAnchor,
                           paddingRight: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
        
        
        //scroll view
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scrollView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 20).isActive = true;
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true;
        //stack view
        scrollView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                     leading: 20,
                                                                     bottom: 20,
                                                                     trailing: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        
        //add things to stack view
        stackView.addArrangedSubview(productImagesCollectionView)
        //collection view delegate and data source
        let height = (view.frame.size.width)-40
        productImagesCollectionView.setHeight(height: height)
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        
        //other product label
        stackView.addArrangedSubview(threeDotsImage)
        stackView.addArrangedSubview(productNameLabel)
        stackView.addArrangedSubview(inStockLabel)
        stackView.addArrangedSubview(productDescriptionLabel)
        stackView.addArrangedSubview(productCategoryLabel)
        stackView.addArrangedSubview(priceStack)
        priceStack.addArrangedSubview(priceTitleLabel)
        priceStack.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(blankLabelOne)
        stackView.addArrangedSubview(customizableTitle)
        stackView.addArrangedSubview(customizableTextField)
        customizableTextField.delegate = self
        stackView.addArrangedSubview(blankLabelTwo)
        stackView.addArrangedSubview(internationalShippingAvailableLabel)
        stackView.addArrangedSubview(blankLabelThree)
        stackView.addArrangedSubview(deliveryInNumberOfDaysLabel)
        stackView.addArrangedSubview(blankLabelFour)
        stackView.addArrangedSubview(sellerStack)
        sellerStack.addArrangedSubview(soldByLabel)
        sellerStack.addArrangedSubview(sellerImageProfileView)
        sellerStack.distribution = .fillProportionally
        stackView.addArrangedSubview(blankLabelFive)
        stackView.addArrangedSubview(buyNowButton)
        setupShadowToButton(button: buyNowButton)
        
    }
}



//MARK: - Collection View Delegate and Data Source
extension ProductDetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.size.width)-40
        return CGSize(width: height, height: height)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCell.identifier, for: indexPath) as! ProductImageCell
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1.2
        cell.layer.borderColor = COLORS.customLavender.cgColor
        
        cell.configure(with: ProductImagesCellViewModel(with: model))
        
        return cell
    }
    
    
    
}


//MARK: - API
extension ProductDetailsVC {
    
    
    
    
    /// Configures the Product Details to the labels and other stuff
    private func configureProductDetails() {
        guard let name = product?.productName,
              let description = product?.productDescription,
              let category = product?.productCategory,
              let price = product?.productPrice,
              let deliveryInDays = product?.productDeliveryInDays,
              let internationalShippingAvailable = product?.isInternationalShippingAvailable,
              let isInStock = product?.itemsInStock,
              let isCustomizable = product?.isCustomizable,
              let images = product?.productImages,
              let ownerID = product?.ownerID,
              let profileImageURL = product?.user?.profileImageURL else { return }
        
        
        //check if current user if viewwing the product
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        if currentUid == ownerID {
            isCurrentUserViewing = true
            buyNowButton.isHidden = true
        } else {
            isCurrentUserViewing = false
        }
        
        productNameLabel.text = name
        productDescriptionLabel.text = description
        productCategoryLabel.text = category
        priceLabel.text = price
        deliveryInNumberOfDaysLabel.text = "📦 Deliver in \(deliveryInDays) days"
        
        //add images in model
        for text in images {
            models.append(ProductImageModel(url: [text]))
        }
        productImagesCollectionView.reloadData()
        
        
        //set profileImageURL
        DispatchQueue.main.async {
            let url = URL(string: profileImageURL)
            self.sellerImageProfileView.sd_setImage(with: url, completed: nil)
            self.sellerImageProfileView.layer.cornerRadius = 50/2
            self.sellerImageProfileView.clipsToBounds = true
        }
        
        
        //check if in stock
        if isInStock >= 1 {
            inStockLabel.text = "\(isInStock) items In Stock"
            inStockLabel.textColor = .systemGreen
        } else {
            inStockLabel.text = "Out of Stock"
            inStockLabel.textColor = .systemRed
        }
        
        
        //check if international shipping available
        if internationalShippingAvailable == "No" {
            internationalShippingAvailableLabel.text = "✈️ International Shipping is NOT AVAILABLE"
        } else {
            internationalShippingAvailableLabel.text = "✈️ Interational Shipping is AVAILABLE"
        }
        
        
        //chek if customizable
        if isCustomizable == "Yes" && currentUid != ownerID{
            print("DEBUG: Customizable")
            customizableTitle.isHidden = false
            customizableTextField.isHidden = false
        } else {
            print("DEBUG: Not Customizable")
            customizableTitle.isHidden = true
            customizableTextField.isHidden = true
        }
    }
    
    
    
    
    
    
    
    /// Handles Delete Product
    private func handleDeleteProduct() {
        print("DEBUG: Show Delete Dialog")
        popUpWithButtons(imgName: SFSYMBOLS.DELETE,
                         btnYesText: "Yes", btnNoText: "No",
                         yesButtonBGColor: .systemRed,
                         noButtonBGColor: .systemGreen,
                         viewBorderColor: COLORS.customLavender,
                         txtMessage: "Are you sure you want to delete this Product?",
                         numOfButtons: 2, completion: { success in
                            if success {
                                self.generateFeedback()
                                print("DEBUG: Yes Delete it")
                                self.performDelete()
                            } else {
                                self.generateFeedback()
                                print("DEBUG: No")
                            }
                         })
    }
    
    
    
    
    
    
    /// Deletes the product images and other info from the refs
    private func performDelete() {
        guard let productID = product?.productID,
              let imgNames = product?.productImageFileNames,
              let ownerID = product?.ownerID,
              let category = product?.productCategory else { return }
        
        for names in imgNames {
            DatabaseManager.shared.deleteProductImageFromFirebase(with: names, completion: { deleted in
                if deleted {
                    //remove product from products Ref
                    DatabaseManager.shared.deleteProduct(with: productID, currentUid: ownerID, category: category, completion: { deleted in
                        if deleted {
                            print("DEBUG: DELETED SUCCESSFULLY FROM ALL REFERENCES")
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            print("DEBUG: SOMETHING WENT WRONG WHILE DELETING")
                        }
                    })
                } else {
                    print("DEBUG: FAILED TO DELETE PRODUCT IMAGES")
                }
            })
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}









//MARK: - Bottom Sheet Extension
extension ProductDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCurrentUserViewing {
            return currentUserOptionsArray.count
        } else {
            return customerOptionsArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isCurrentUserViewing {
            let cell = bottomSheetTableView.dequeueReusableCell(withIdentifier: ProfileSettingsMenuCell.identifier, for: indexPath) as! ProfileSettingsMenuCell
            cell.leftLabel.text = currentUserOptionsArray[indexPath.row]
            cell.leftImageView.image = currentUserOptionsImages[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = bottomSheetTableView.dequeueReusableCell(withIdentifier: ProfileSettingsMenuCell.identifier, for: indexPath) as! ProfileSettingsMenuCell
            cell.leftLabel.text = customerOptionsArray[indexPath.row]
            cell.leftImageView.image = customerOptionsImages[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClickTransparentView()
        if isCurrentUserViewing {
            switch indexPath.row {
            case 0:
                generateFeedback()
                print("DEBUG: Edit Product")
                guard let product = self.product else { return }
                navigationController?.pushViewController(EditProductVC(product: product), animated: true)
            case 1:
                generateFeedback()
                print("DEBUG: Delete Product")
                handleDeleteProduct()
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                generateFeedback()
                print("DEBUG: Report Product")
                reportProductTapped()
            case 1:
                generateFeedback()
                print("DEBUG: Save For Later")
                saveProductTapped()
            default:
                break
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    /// Animates the Bottom Sheet in the View Controller
    private func showBottomSheet() {
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = view.frame
        view.addSubview(transparentView)
        //table view
        let screenSize = UIScreen.main.bounds.size
        bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 120)
        //height = 250 because 5 cells of size 50
        view.addSubview(bottomSheetTableView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        //Animate in the tableview
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height-120, width: screenSize.width, height: 120)
        }, completion: nil)
    }
    
    
    
    
    
    /// Selectors of Transparent View Tap Gesture, Animates out the View and Table View
    @objc private func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        //Animate the tableview out of screen
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.generateFeedback()
            self.transparentView.alpha = 0
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 120)
        }, completion: nil)
    }
    
    
}




//MARK: - TextField Delegate
extension ProductDetailsVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}



//MARK: - API
extension ProductDetailsVC {
    
    
    
    
    /// Save product To Firebase and users saved List
    private func saveProductTapped() {
        print("DEBUG: Saving Product Here")
        guard let productID = product?.productID else { return }
        DatabaseManager.shared.saveProductForUser(productID: productID, completion: { saved in
            if saved {
                print("DEBUG: Saved")
                ToastView.shared.short(self.view, txt_msg: REPORT_TXT.SAVED)
            } else {
                print("DEBUG: Failed To Save")
                ToastView.shared.short(self.view, txt_msg: REPORT_TXT.FAILED_SAVE)
            }
        })
    }
    
    
    
    
    
    /// Adds product to the report ref
    private func reportProductTapped() {
        print("DEBUG: Reporting Product Here")
        guard let productID = product?.productID else { return }
        DatabaseManager.shared.reportProduct(productID: productID, completion: { reported in
            if reported {
                print("DEBUG: Reported")
                let popUp = CustomPopUp(popupTitle: REPORT_TXT.TITLE, popupSubtitle: REPORT_TXT.MSG, customImage: #imageLiteral(resourceName: "icons8-grinning-face-with-big-eyes-48"))
                self.view.addSubview(popUp)
            } else {
                print("DEBUG: Failed TO report")
                ToastView.shared.short(self.view, txt_msg: REPORT_TXT.FAILED)
            }
        })
    }
    
    
    
    
    
    
}
