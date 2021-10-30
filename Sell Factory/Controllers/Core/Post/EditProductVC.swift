//
//  EditProductVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/4/21.
//

import UIKit
import Firebase
import JGProgressHUD


class EditProductVC: UIViewController {
    
    //MARK: - Properties
    var product: Product?
        
    var isImageOneSelected = false
    var isImageTwoSelected = false
    var isImageThreeSelected = false
    var isImageFourSelected = false
    var isImageFiveSelected = false
    var isImageSixSelected = false
    
    var imageOneFileName = ""
    var imageTwoFileName = ""
    var imageThreeFileName = ""
    var imageFourFileName = ""
    var imageFiveFileName = ""
    var imageSixFileName = ""
    
    var productImagesList = [String]()
    var productImageFileNames = [String]()
    var currentImage: UIImageView? = nil
    var imageNumber = ""
    
    var currency = "$"
    var isCustomizable = "Yes"
    var isInternationalShippingAvailable = "Yes"
    
    var firstImageUrl = ""
    
    
    private let spinner: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading..."
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    private let pageTitleLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.POST,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    //Horizontal Images
    private let addImageTitleLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.ADD_IMAGES,
                                             fontName: Font.menloBold,
                                             fontSize: 14, noOfLines: 1,
                                             texxtColor: .secondaryLabel,
                                             texxtAlignment: .center)
    
    private let imageDescriptionLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.IMG_DESCRIPTION,
                                                fontName: Font.menlo,
                                                fontSize: 12,
                                                noOfLines: 0,
                                                texxtColor: .secondaryLabel,
                                                texxtAlignment: .justified)
    
    
    
    private let productImageOne: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: true, isInteractable: true, dim: 80)
        iv.image = UIImage(systemName: SFSYMBOLS.POST)
        iv.tintColor = .secondaryLabel
        return iv
    }()

    
    private let productImageTwo: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: true, isInteractable: true, dim: 80)
        iv.image = UIImage(systemName: SFSYMBOLS.POST)
        iv.tintColor = .secondaryLabel
        return iv
    }()

    
    private let productImageThree: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: true, isInteractable: true, dim: 80)
        iv.image = UIImage(systemName: SFSYMBOLS.POST)
        iv.tintColor = .secondaryLabel
        return iv
    }()

    private let productImageFour: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: true, isInteractable: true, dim: 80)
        iv.image = UIImage(systemName: SFSYMBOLS.POST)
        iv.tintColor = .secondaryLabel
        return iv
    }()

    private let productImageFive: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: true, isInteractable: true, dim: 80)
        iv.image = UIImage(systemName: SFSYMBOLS.POST)
        iv.tintColor = .secondaryLabel
        return iv
    }()

    private let productImageSix: SFImageView = {
        let iv = SFImageView(bgColor: .clear, contentmode: .scaleAspectFit, clipsTobounds: true, isInteractable: true, dim: 80)
        iv.image = UIImage(systemName: SFSYMBOLS.POST)
        iv.tintColor = .secondaryLabel
        return iv
    }()
    
    private let cancelFirstImage: SFImageButton = {
        let button = SFImageButton(dim: 35, imageName: SFSYMBOLS.CROSS, color: .red)
        button.addTarget(self, action: #selector(cancelFirstImageTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let cancelSecondImage: SFImageButton = {
        let button = SFImageButton(dim: 35, imageName: SFSYMBOLS.CROSS, color: .red)
        button.addTarget(self, action: #selector(cancelSecondImageTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let cancelThirdImage: SFImageButton = {
        let button = SFImageButton(dim: 35, imageName: SFSYMBOLS.CROSS, color: .red)
        button.addTarget(self, action: #selector(cancelThirdImageTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let cancelFourthImage: SFImageButton = {
        let button = SFImageButton(dim: 35, imageName: SFSYMBOLS.CROSS, color: .red)
        button.addTarget(self, action: #selector(cancelFourthImageTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let cancelFifthImage: SFImageButton = {
        let button = SFImageButton(dim: 35, imageName: SFSYMBOLS.CROSS, color: .red)
        button.addTarget(self, action: #selector(cancelFifthImageTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let cancelSixthImage: SFImageButton = {
        let button = SFImageButton(dim: 35, imageName: SFSYMBOLS.CROSS, color: .red)
        button.addTarget(self, action: #selector(cancelSixthImageTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    private let productImageStack = SFStackView(stackAxis: .horizontal, stackSpace: 10)
    
    private let productImageScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private let productScrollBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    
    
    //ScrollView & StackView to Add Other Items
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
    
    
    
    //Other Elements
    private let productNameTextField = SFTextField(placeHolder: POST_PRODUCT_TEXTS.NAME,
                                                   autoCapital: .none,
                                                   autoCorrect: .no,
                                                   isSecure: false, height: CONST.TF_HEIGHT)
    
    private let productDescriptionTextField = SFTextField(placeHolder: POST_PRODUCT_TEXTS.DESCRIPTION,
                                                          autoCapital: .none,
                                                          autoCorrect: .no,
                                                          isSecure: false, height: CONST.TF_HEIGHT)
    
    private let productCategoryTitleLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.CATEGORY,
                                                         fontName: Font.menlo,
                                                         fontSize: 14, noOfLines: 0, texxtColor: .secondaryLabel, texxtAlignment: .left)
    
    private let productCategoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .secondarySystemBackground
        label.text = POST_PRODUCT_TEXTS.NO_CATEGORY
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.setHeight(height: CONST.BUTTON_HEIGHT)
        label.layer.cornerRadius = CONST.CORNER_RADII
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.font = UIFont(name: Font.menlo, size: 16)
        return label
    }()
    
    
    
    private let productPriceTextField: SFTextField = {
        let tf = SFTextField(placeHolder: POST_PRODUCT_TEXTS.PRICE,
                             autoCapital: .none,
                             autoCorrect: .no,
                             isSecure: false, height: CONST.TF_HEIGHT)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let productPriceItem = [POST_PRODUCT_TEXTS.DOLLAR,POST_PRODUCT_TEXTS.RUPEE,POST_PRODUCT_TEXTS.POUNDS,POST_PRODUCT_TEXTS.EUROS]
    lazy var productPriceSegmentControls: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: productPriceItem)
        segmentedControl.setHeight(height: 45)
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = COLORS.customLavender
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 9
        segmentedControl.layer.masksToBounds = true
        segmentedControl.addTarget(self, action: #selector(productPriceSegmentTapped(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private let productPriceStack = SFStackView(stackAxis: .horizontal, stackSpace: 8)
    
    
    
    
    private let deliveryInDaysTextField: SFTextField = {
        let tf = SFTextField(placeHolder: POST_PRODUCT_TEXTS.DELIVERY,
                             autoCapital: .none,
                             autoCorrect: .no,
                             isSecure: false, height: CONST.TF_HEIGHT)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private let numberOfItemsInStockTitleLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.ITEM_IN_STOCK,
                                                         fontName: Font.menlo,
                                                         fontSize: 14,
                                                         noOfLines: 0,
                                                         texxtColor: .secondaryLabel,
                                                         texxtAlignment: .left)
    
    private let numberOfItemsInStockCountLabel = SFLabel(texxt: "",
                                                         fontName: Font.menlo,
                                                         fontSize: 14,
                                                         noOfLines: 0,
                                                         texxtColor: .label,
                                                         texxtAlignment: .center)
    
    
    var itemInStock: Int = 1
    private let plusButton: SFButton = {
        let button = SFButton(placeHolder: POST_PRODUCT_TEXTS.PLUS)
        button.addTarget(self, action: #selector(handlePlusStockButtonTapped), for: .touchUpInside)
        return button
    }()
    private let minusButton: SFButton = {
        let button = SFButton(placeHolder: POST_PRODUCT_TEXTS.MINUS)
        button.addTarget(self, action: #selector(handleMinusStockButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let inStockStackView = SFStackView(stackAxis: .horizontal, stackSpace: 5)
    
    
    private let internationalShippingTitleLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.INTERNATIONAL,
                                                         fontName: Font.menlo,
                                                         fontSize: 14,
                                                         noOfLines: 0,
                                                         texxtColor: .secondaryLabel,
                                                         texxtAlignment: .left)
    
    let internationalShippingItem = [POST_PRODUCT_TEXTS.YES,POST_PRODUCT_TEXTS.NO]
    lazy var internationalShippingSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: internationalShippingItem)
        segmentedControl.setHeight(height: 45)
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = COLORS.customLavender
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 9
        segmentedControl.layer.masksToBounds = true
        segmentedControl.addTarget(self, action: #selector(internationalShippingSegmentTapped(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    
    
    
    
    private let customizableLabel = SFLabel(texxt: POST_PRODUCT_TEXTS.CUSTOMIZABLE,
                                                         fontName: Font.menlo,
                                                         fontSize: 14,
                                                         noOfLines: 0,
                                                         texxtColor: .secondaryLabel,
                                                         texxtAlignment: .left)
    
    
    
    let customizableItem = [POST_PRODUCT_TEXTS.YES, POST_PRODUCT_TEXTS.NO]
    lazy var customizableProductSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: customizableItem)
        segmentedControl.setHeight(height: 45)
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = COLORS.customLavender
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 9
        segmentedControl.layer.masksToBounds = true
        segmentedControl.addTarget(self, action: #selector(customizableProductSegmentTapped(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    
    
    //Bottom Sheet
    var transparentView = UIView()
    lazy var bottomSheetTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.isScrollEnabled = true
        tv.showsVerticalScrollIndicator = false
        tv.register(CategoryListCell.self, forCellReuseIdentifier: CategoryListCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        tv.layer.cornerRadius = 20
        tv.layer.borderWidth = 2
        tv.layer.borderColor = COLORS.customLavender.cgColor
        return tv
    }()
    var categoryArray = [CATEGORY.ALL, CATEGORY.ELECTRONICS,
                         CATEGORY.HOME, CATEGORY.GARDEN,
                         CATEGORY.CRAFT, CATEGORY.FURNITURE,
                         CATEGORY.PET, CATEGORY.CLOTHES,
                         CATEGORY.FOOD, CATEGORY.TOY,
                         CATEGORY.HANDMADE, CATEGORY.SPORTS,
                         CATEGORY.TOOLS, CATEGORY.OTHERS]

    
    private let postProductButton: SFButton = {
        let button = SFButton(placeHolder: POST_PRODUCT_TEXTS.UPDATE)
        button.addTarget(self, action: #selector(handlePostProductButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
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
        setupProductDetails()
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Configures Basic UI of the View Controller
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
    
    
    
    
    
    /// Handles Plus Stock Button Tap
    @objc private func handlePlusStockButtonTapped() {
        generateFeedback()
        print("DEBUG: Plus Stock Button Tapped")
        itemInStock += 1
        numberOfItemsInStockCountLabel.text = "\(itemInStock)"
    }
    
    
    
    /// Handles Minus Stock Button Tap
    @objc private func handleMinusStockButtonTapped() {
        generateFeedback()
        print("DEBUG: Minus Stock Button Tapped")
        if itemInStock <= 1 {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.MINU_BUTTON_ERROR, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            view.addSubview(popUp)
        } else {
            itemInStock -= 1
            numberOfItemsInStockCountLabel.text = "\(itemInStock)"
        }
    }
    
    
    
    /// Segment Control To see If International Shipping is Available
    /// - Parameter segmentedControl: segmented control
    @objc func internationalShippingSegmentTapped(_ segmentedControl:UISegmentedControl!) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            generateFeedback()
            print("DEBUG: Yes")
            isInternationalShippingAvailable = "Yes"
            break
        case 1:
            generateFeedback()
            print("DEBUG: No")
            isInternationalShippingAvailable = "No"
            break
        default:
            break
        }
    }
    
    
    /// Segment Control To see If International Shipping is Available
    /// - Parameter segmentedControl: segmented control
    @objc func customizableProductSegmentTapped(_ segmentedControl:UISegmentedControl!) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            generateFeedback()
            print("DEBUG: Yes")
            isCustomizable = "Yes"
            break
        case 1:
            generateFeedback()
            print("DEBUG: No")
            isCustomizable = "No"
            break
        default:
            break
        }
    }
    
    
    
    /// Segment Control To see If International Shipping is Available
    /// - Parameter segmentedControl: segmented control
    @objc func productPriceSegmentTapped(_ segmentedControl:UISegmentedControl!) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            generateFeedback()
            print("DEBUG: Dollar")
            currency = TXT.DOLLAR
            break
        case 1:
            generateFeedback()
            print("DEBUG: Rupee")
            currency = TXT.RUPEE
            break
        case 2:
            generateFeedback()
            print("DEBUG: Pounds")
            currency = TXT.POUNDS
            break
        case 3:
            generateFeedback()
            print("DEBUG: Euros")
            currency = TXT.EUROS
            break
        default:
            break
        }
    }
    

    
    
    /// Handles Product Category Tapped
    @objc private func productCategoryLabelTapped() {
        generateFeedback()
        print("DEBUG: Choose Category From Here")
        showBottomSheet()
    }
    
    
    
    
    
    
    /// Handles Post Button Tap
    @objc private func handlePostProductButtonTapped() {
        generateFeedback()
        print("DEBUG: Update Product Here")
        updateProduct()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extension

//MARK: - TextField Delegate
extension EditProductVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


//>ARK: - Configure View Extension
extension EditProductVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
        view.addSubview(productScrollBackgroundView)
        view.addSubview(addImageTitleLabel)
        view.addSubview(scrollView)
        view.addSubview(cancelFirstImage)
        view.addSubview(cancelSecondImage)
        view.addSubview(cancelThirdImage)
        view.addSubview(cancelFourthImage)
        view.addSubview(cancelFifthImage)
        view.addSubview(cancelSixthImage)
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
        
        //Horizontal Image Scroll View
        productScrollBackgroundView.setHeight(height: 80)
        productScrollBackgroundView.anchor(top: pageTitleLabel.bottomAnchor,
                                            left: view.leftAnchor,
                                            bottom: nil,
                                            right: view.rightAnchor,
                                            paddingTop: 25,
                                            paddingLeft: 10,
                                            paddingRight: 10)
        productScrollBackgroundView.addSubview(productImageScrollView)
        productImageScrollView.anchor(top: productScrollBackgroundView.topAnchor,
                                  left: productScrollBackgroundView.leftAnchor,
                                  bottom: productScrollBackgroundView.bottomAnchor,
                                  right: productScrollBackgroundView.rightAnchor)
        productImageScrollView.addSubview(productImageStack)
        productImageStack.anchor(top: productImageScrollView.topAnchor,
                                  left: productImageScrollView.leftAnchor,
                                  bottom: productImageScrollView.bottomAnchor,
                                  right: productImageScrollView.rightAnchor)
        productImageStack.addArrangedSubview(productImageOne)
        productImageStack.addArrangedSubview(productImageTwo)
        productImageStack.addArrangedSubview(productImageThree)
        productImageStack.addArrangedSubview(productImageFour)
        productImageStack.addArrangedSubview(productImageFive)
        productImageStack.addArrangedSubview(productImageSix)
        
        cancelFirstImage.anchor(top: productImageOne.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: productImageOne.rightAnchor)
        
        cancelSecondImage.anchor(top: productImageTwo.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: productImageTwo.rightAnchor)
        
        cancelThirdImage.anchor(top: productImageThree.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: productImageThree.rightAnchor)
        
        cancelFourthImage.anchor(top: productImageFour.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: productImageFour.rightAnchor)
        
        cancelFifthImage.anchor(top: productImageFive.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: productImageFive.rightAnchor)
        
        cancelSixthImage.anchor(top: productImageSix.topAnchor,
                                left: nil,
                                bottom: nil,
                                right: productImageSix.rightAnchor)
        
        
        //Images Tap Gesture:
        let imageOneTap = UITapGestureRecognizer(target: self, action: #selector(didTapFirstImage))
        productImageOne.addGestureRecognizer(imageOneTap)
        
        let imageTwoTap = UITapGestureRecognizer(target: self, action: #selector(didTapSecondImage))
        productImageTwo.addGestureRecognizer(imageTwoTap)
        
        let imageThreeTap = UITapGestureRecognizer(target: self, action: #selector(didTapThirdImage))
        productImageThree.addGestureRecognizer(imageThreeTap)
        
        let imageFourTap = UITapGestureRecognizer(target: self, action: #selector(didTapFourthImage))
        productImageFour.addGestureRecognizer(imageFourTap)
        
        let imageFiveTap = UITapGestureRecognizer(target: self, action: #selector(didTapFifthImage))
        productImageFive.addGestureRecognizer(imageFiveTap)
        
        let imageSixTap = UITapGestureRecognizer(target: self, action: #selector(didTapSixthImage))
        productImageSix.addGestureRecognizer(imageSixTap)
        
        
        
        addImageTitleLabel.anchor(top: productScrollBackgroundView.bottomAnchor,
                                  left: view.leftAnchor,
                                  bottom: nil,
                                  right: view.rightAnchor,
                                  paddingTop: 8,
                                  paddingLeft: 15,
                                  paddingRight: 15)
        
        
        //Scroll View & Stack View to Add Other Items
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scrollView.topAnchor.constraint(equalTo: addImageTitleLabel.bottomAnchor, constant: 20).isActive = true;
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true;
        
        //adding stackview to scrollview
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
        
        //Just Add everything else to Stack View
        stackView.addArrangedSubview(imageDescriptionLabel)
        //name
        stackView.addArrangedSubview(productNameTextField)
        productNameTextField.delegate = self
        
        //description
        stackView.addArrangedSubview(productDescriptionTextField)
        productDescriptionTextField.delegate = self
        
        //black
        stackView.addArrangedSubview(blankLabelOne)
        
        //category
        stackView.addArrangedSubview(productCategoryTitleLabel)
        stackView.addArrangedSubview(productCategoryLabel)
        let categoryTap = UITapGestureRecognizer(target: self, action: #selector(productCategoryLabelTapped))
        productCategoryLabel.addGestureRecognizer(categoryTap)
        
        //blank
        stackView.addArrangedSubview(blankLabelTwo)
        
        //price
        stackView.addArrangedSubview(productPriceStack)
        productPriceStack.distribution = .fillEqually
        productPriceStack.addArrangedSubview(productPriceTextField)
        productPriceStack.addArrangedSubview(productPriceSegmentControls)
        productPriceTextField.delegate = self
        
        //blank
        stackView.addArrangedSubview(blankLabelThree)
        
        //delivery
        stackView.addArrangedSubview(deliveryInDaysTextField)
        deliveryInDaysTextField.delegate = self
        
        //blank
        stackView.addArrangedSubview(blankLabelFour)
        
        //customizable
        stackView.addArrangedSubview(customizableLabel)
        stackView.addArrangedSubview(customizableProductSegmentControl)
        
        //blank
        stackView.addArrangedSubview(blankLabelFive)
        
        //international shipping
        stackView.addArrangedSubview(internationalShippingTitleLabel)
        stackView.addArrangedSubview(internationalShippingSegmentedControl)
        
        //blank
        stackView.addArrangedSubview(blankLabelSix)
        
        //items in stock
        stackView.addArrangedSubview(numberOfItemsInStockTitleLabel)
        stackView.addArrangedSubview(inStockStackView)
        inStockStackView.distribution = .fillEqually
        inStockStackView.addArrangedSubview(minusButton)
        inStockStackView.addArrangedSubview(numberOfItemsInStockCountLabel)
        numberOfItemsInStockCountLabel.text = "\(itemInStock)"
        inStockStackView.addArrangedSubview(plusButton)
        
        //blank
        stackView.addArrangedSubview(blankLabelSeven)
        
        
        //post product button
        stackView.addArrangedSubview(postProductButton)
    }
    
}





//MARK: - Extensions

//MARK: - Bottom Sheet Extension
extension EditProductVC: UITableViewDelegate, UITableViewDataSource {
    
    //TABLE VIEW DELEGATES & DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bottomSheetTableView.dequeueReusableCell(withIdentifier: CategoryListCell.identifier, for: indexPath) as! CategoryListCell
        cell.selectionStyle = .none
        cell.categoryNameLabel.text = categoryArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClickTransparentView()
        productCategoryLabel.text = categoryArray[indexPath.row]
    }
    
    

    /// Animates the Bottom Sheet in the View Controller
    private func showBottomSheet() {
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = view.frame
        view.addSubview(transparentView)
        //table view
        let screenSize = UIScreen.main.bounds.size
        bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 280)
        //height = 250 because 5 cells of size 50
        view.addSubview(bottomSheetTableView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        //Animate in the tableview
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height-280, width: screenSize.width, height: 280)
        }, completion: nil)
    }
    
    
    
    
    
    /// Selectors of Transparent View Tap Gesture, Animates out the View and Table View
    @objc private func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        //Animate the tableview out of screen
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.generateFeedback()
            self.transparentView.alpha = 0
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 280)
        }, completion: nil)
    }
    
    
}





//MARK: - Image Tap Gesture Extensions
extension EditProductVC {
    
    
    
    /// Handles Tap Gesture of Image One
    @objc private func didTapFirstImage() {
        generateFeedback()
        print("DEBUG: Image 1 Tapped")
        currentImage = productImageOne
        imageNumber = "1"
        presentPhotoPicker()
    }
    
    
    
    /// Cancels First Image View
    @objc private func cancelFirstImageTapped() {
        generateFeedback()
        print("DEBUG: Cancel First Image Tapped")
        deleteImage(with: imageOneFileName, index: 0, resetImageView: productImageOne, cancelImage: cancelFirstImage)
        isImageOneSelected = false
        firstImageUrl = ""
    }
    
    

    
    
    
    
    
    
    
    
    /// Handles Tap Gesture of Image One
    @objc private func didTapSecondImage() {
        generateFeedback()
        print("DEBUG: Image 2 Tapped")
        currentImage = productImageTwo
        imageNumber = "2"
        presentPhotoPicker()
    }
    
    
    
    
    /// Cancels Second Image View
    @objc private func cancelSecondImageTapped() {
        generateFeedback()
        print("DEBUG: Cancel Second Image Tapped")
        deleteImage(with: imageTwoFileName, index: 1, resetImageView: productImageTwo, cancelImage: cancelSecondImage)
        isImageTwoSelected = false
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// Handles Tap Gesture of Image One
    @objc private func didTapThirdImage() {
        generateFeedback()
        print("DEBUG: Image 3 Tapped")
        currentImage = productImageThree
        imageNumber = "3"
        presentPhotoPicker()
    }
    
    
    /// Cancels Second Image View
    @objc private func cancelThirdImageTapped() {
        generateFeedback()
        print("DEBUG: Cancel Three Image Tapped")
        deleteImage(with: imageThreeFileName, index: 2, resetImageView: productImageThree, cancelImage: cancelThirdImage)
        isImageThreeSelected = false
    }
    
    
    
    
    
    
    
    
    
    /// Handles Tap Gesture of Image One
    @objc private func didTapFourthImage() {
        generateFeedback()
        print("DEBUG: Image 4 Tapped")
        currentImage = productImageFour
        imageNumber = "4"
        presentPhotoPicker()
    }
    
    /// Cancels Second Image View
    @objc private func cancelFourthImageTapped() {
        generateFeedback()
        print("DEBUG: Cancel Fourth Image Tapped")
        deleteImage(with: imageFourFileName, index: 3, resetImageView: productImageFour, cancelImage: cancelFourthImage)
        isImageFourSelected = false
    }
    
    
    
    
    
    
    
    
    /// Handles Tap Gesture of Image One
    @objc private func didTapFifthImage() {
        generateFeedback()
        print("DEBUG: Image 5 Tapped")
        currentImage = productImageFive
        imageNumber = "5"
        presentPhotoPicker()
    }
    
    
    /// Cancels Second Image View
    @objc private func cancelFifthImageTapped() {
        generateFeedback()
        print("DEBUG: Cancel Fifth Image Tapped")
        deleteImage(with: imageFiveFileName, index: 4, resetImageView: productImageFive, cancelImage: cancelFifthImage)
        isImageFiveSelected = false
    }
    
    
    
    
    
    
    
    
    
    /// Handles Tap Gesture of Image One
    @objc private func didTapSixthImage() {
        generateFeedback()
        print("DEBUG: Image 6 Tapped")
        currentImage = productImageSix
        imageNumber = "6"
        presentPhotoPicker()
    }
    
    /// Cancels Second Image View
    @objc private func cancelSixthImageTapped() {
        generateFeedback()
        print("DEBUG: Cancel Sixth Image Tapped")
        deleteImage(with: imageSixFileName, index: 5, resetImageView: productImageSix, cancelImage: cancelSixthImage)
        isImageSixSelected = false
    }
    

}










//MARK: - Extension

//MARK: - Photo Picker Delegate
extension EditProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    /// Presents Photo Picker
    private func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        //assign image
        self.assignImage(selectedImage: image)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    ///Function to assign selected image
    private func assignImage(selectedImage: UIImage) {
        if imageNumber == "1" {
            isImageOneSelected = true
            cancelFirstImage.isHidden = false
            productImageOne.image = selectedImage
            //Create File Name
            let result = NSUUID().uuidString
            let date = DatabaseManager.safeDate(date: Date())
            let fileName = "product_\(result)_\(date)"
            imageOneFileName = fileName
            //add file name
            productImageFileNames.append(imageOneFileName)
            //upload image
            upload(with: selectedImage, imageNumber: "1", fileName: fileName)
        } else if imageNumber == "2" {
            isImageTwoSelected = true
            cancelSecondImage.isHidden = false
            productImageTwo.image = selectedImage
            //Create File Name
            let result = NSUUID().uuidString
            let date = DatabaseManager.safeDate(date: Date())
            let fileName = "product_\(result)_\(date)"
            imageTwoFileName = fileName
            //add file name
            productImageFileNames.append(imageTwoFileName)
            //upload image
            upload(with: selectedImage, imageNumber: "2", fileName: fileName)
        } else if imageNumber == "3" {
            isImageThreeSelected = true
            cancelThirdImage.isHidden = false
            productImageThree.image = selectedImage
            //Create File Name
            let result = NSUUID().uuidString
            let date = DatabaseManager.safeDate(date: Date())
            let fileName = "product_\(result)_\(date)"
            imageThreeFileName = fileName
            //add file name
            productImageFileNames.append(imageThreeFileName)
            //upload image
            upload(with: selectedImage, imageNumber: "3", fileName: fileName)
        } else if imageNumber == "4" {
            isImageFourSelected = true
            cancelFourthImage.isHidden = false
            productImageFour.image = selectedImage
            //Create File Name
            let result = NSUUID().uuidString
            let date = DatabaseManager.safeDate(date: Date())
            let fileName = "product_\(result)_\(date)"
            imageFourFileName = fileName
            //add file name
            productImageFileNames.append(imageFourFileName)
            //upload image
            upload(with: selectedImage, imageNumber: "4", fileName: fileName)
        } else if imageNumber == "5" {
            isImageFiveSelected = true
            cancelFifthImage.isHidden = false
            productImageFive.image = selectedImage
            //Create File Name
            let result = NSUUID().uuidString
            let date = DatabaseManager.safeDate(date: Date())
            let fileName = "product_\(result)_\(date)"
            imageFiveFileName = fileName
            //add file name
            productImageFileNames.append(imageFiveFileName)
            //upload image
            upload(with: selectedImage, imageNumber: "5",fileName: fileName)
        } else {
            isImageSixSelected = true
            cancelSixthImage.isHidden = false
            productImageSix.image = selectedImage
            //Create File Name
            let result = NSUUID().uuidString
            let date = DatabaseManager.safeDate(date: Date())
            let fileName = "product_\(result)_\(date)"
            imageSixFileName = fileName
            //add file name
            productImageFileNames.append(imageSixFileName)
            //upload image
            upload(with: selectedImage, imageNumber: "6", fileName: fileName)
        }
    }

    
    

    /// Uploads Image To Firebase
    /// - Parameters:
    ///   - image: UIImage
    ///   - imageNumber: String
    private func upload(with image: UIImage, imageNumber: String, fileName: String) {
        spinner.show(in: view)
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else {
            spinner.dismiss()
            return
        }
        DatabaseManager.shared.uploadProductPictures(with: uploadData, fileName: fileName, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let downloadURL):
                if imageNumber == "1" {
                    strongSelf.firstImageUrl = downloadURL
                }
                if strongSelf.productImagesList.count == 6 {
                    strongSelf.spinner.dismiss()
                    let popup = CustomPopUp(popupTitle: "OOPS!!", popupSubtitle: "You have already added six images..after uploading go to edit projects to change an image.", customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                    strongSelf.view.addSubview(popup)
                    return
                } else {
                    strongSelf.spinner.dismiss()
                    strongSelf.productImagesList.append(downloadURL)
                    let popup = CustomPopUp(popupTitle: "Added", popupSubtitle: "Your Product Image was added. Would you like to add more?", customImage: UIImage(systemName: "photo.on.rectangle.angled")!)
                    strongSelf.view.addSubview(popup)
                }
            case .failure(let error):
                strongSelf.spinner.dismiss()
                print("DEBUG: Error: \(error.localizedDescription)")
            }
        })
        
    }
    
    
    
    
    
    
    
    
    /// Adds the Product To the Database
    public func updateProduct() {
        guard let productName = productNameTextField.text, !productName.trimmingCharacters(in: .whitespaces).isEmpty,
              let productDescription = productDescriptionTextField.text, !productDescription.trimmingCharacters(in: .whitespaces).isEmpty,
              let category = productCategoryLabel.text, category != POST_PRODUCT_TEXTS.NO_CATEGORY,
              let price = productPriceTextField.text, !price.trimmingCharacters(in: .whitespaces).isEmpty,
              let deliveryInDays = deliveryInDaysTextField.text, !deliveryInDays.trimmingCharacters(in: .whitespaces).isEmpty, isImageOneSelected == true,
              firstImageUrl != ""
        else {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.MISSING_FIELDS_2, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            view.addSubview(popUp)
            return
        }
        
        guard let productID = product?.productID else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let creationDate = Int(NSDate().timeIntervalSince1970)
        let finalPrice = "\(price) \(currency)"
        let dictionary = [PRODUCT.productName: productName,
                          PRODUCT.productDescription: productDescription,
                          PRODUCT.productCategory: category,
                          PRODUCT.productPrice: finalPrice,
                          PRODUCT.productDeliveryInDays: deliveryInDays,
                          PRODUCT.isCustomizable: isCustomizable,
                          PRODUCT.isInternationalShippingAvailable: isInternationalShippingAvailable,
                          PRODUCT.itemsInStock: itemInStock,
                          PRODUCT.creationDate: creationDate,
                          PRODUCT.ownerID: currentUid,
                          PRODUCT.coverImageURL: firstImageUrl,
                          PRODUCT.productImageFileNames: productImageFileNames,
                          PRODUCT.productImages: productImagesList] as [String: AnyObject]
        
        DatabaseManager.shared.updateProduct(productID: productID, dictionary: dictionary, completion: { updated in
            if updated {
                let popUp = CustomPopUp(popupTitle: POPUP.UPDATED_TITLE, popupSubtitle: POPUP.UPDATED_MSG, customImage: #imageLiteral(resourceName: "icons8-grinning-face-with-big-eyes-48"))
                self.view.addSubview(popUp)
            } else {
                let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.UPDATE_FAILED, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                self.view.addSubview(popUp)
            }
        })
        
    }
    
    
    
    
    
    
    /// Deletes Image Files From Firebase
    /// - Parameter fileName: String
    private func deleteImage(with fileName: String, index: Int, resetImageView: UIImageView, cancelImage: SFImageButton) {
        DatabaseManager.shared.deleteProductImageFromFirebase(with: fileName, completion: { delete in
            if delete {
                self.imageNumber = ""
                //remove from both arrays
                self.productImagesList.remove(at: index)
                self.productImageFileNames.remove(at: index)
                //reset imageview
                resetImageView.image = UIImage(systemName: SFSYMBOLS.POST)
                cancelImage.isHidden = true
                ToastView.shared.short(self.view, txt_msg: "Deleted")
            } else {
                ToastView.shared.short(self.view, txt_msg: "Failed to delete")
            }
        })
    }
    
    
    
    
    
    
    /// Sets up the product details from the previous View Controller
    private func setupProductDetails() {
        guard let product = self.product else { return }
        guard let name = product.productName,
              let description = product.productDescription,
              let category = product.productCategory,
              let price = product.productPrice,
              let internationalShipping = product.isInternationalShippingAvailable,
              let deliveryDays = product.productDeliveryInDays,
              let stockCount = product.itemsInStock,
              let urlLists = product.productImages,
              let fileNames = product.productImageFileNames,
              let coverImageURL = product.coverImageURL,
              let customizable = product.isCustomizable else { return }
        
        //append filenames
        for names in fileNames {
            productImageFileNames.append(names)
        }
        
        productNameTextField.text = name
        productDescriptionTextField.text = description
        productCategoryLabel.text = category
        
        //price
        let split = price.split(separator: " ")
        let finalCost: String = String(split[0])
        let currency: String = String(split[1])
        productPriceTextField.text = finalCost
        
        //set currency
        if currency == POST_PRODUCT_TEXTS.DOLLAR {
            productPriceSegmentControls.selectedSegmentIndex = 0
        } else if currency == POST_PRODUCT_TEXTS.RUPEE {
            productPriceSegmentControls.selectedSegmentIndex = 1
        } else if currency == POST_PRODUCT_TEXTS.POUNDS {
            productPriceSegmentControls.selectedSegmentIndex = 2
        } else {
            productPriceSegmentControls.selectedSegmentIndex = 3
        }
        
        //set international shipping
        if internationalShipping == "No" {
            internationalShippingSegmentedControl.selectedSegmentIndex = 1
        }
        
        
        //set customizable
        if customizable == "No" {
            customizableProductSegmentControl.selectedSegmentIndex = 1
        }
        
        
        //set item stocks
        itemInStock = stockCount
        numberOfItemsInStockCountLabel.text = "\(itemInStock)"
        deliveryInDaysTextField.text = deliveryDays
        firstImageUrl = coverImageURL
        
        //Set Images
        for (index, url) in urlLists.enumerated() {
            let productURL = URL(string: url)
            productImagesList.append(url)
            
            let array = [productImageOne, productImageTwo, productImageThree, productImageFour, productImageFive, productImageSix]
            let cancelImage = [cancelFirstImage, cancelSecondImage, cancelThirdImage, cancelFourthImage, cancelFifthImage, cancelSixthImage]
            let imageName = array[index]
            cancelImage[index].isHidden = false
            DispatchQueue.main.async {
                imageName.sd_setImage(with: productURL, completed: nil)
            }
        }
        
        //set image one true if there
        if productImagesList[0] != "" {
            isImageOneSelected = true
        }

        
        //set filename strings
        for (index, name) in productImageFileNames.enumerated() {
            if index == 0 && !productImageFileNames.isEmpty {
                imageOneFileName = name
            } else if index == 1 && !productImageFileNames.isEmpty {
                imageTwoFileName = name
            } else if index == 2 && !productImageFileNames.isEmpty {
                imageThreeFileName = name
            } else if index == 3 && !productImageFileNames.isEmpty {
                imageFourFileName = name
            } else if index == 4 && !productImageFileNames.isEmpty {
                imageFiveFileName = name
            } else if index == 5  && !productImageFileNames.isEmpty {
                imageSixFileName = name
            }
        }
    }
}
