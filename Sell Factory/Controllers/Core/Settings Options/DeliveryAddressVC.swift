//
//  DeliveryAddressVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import UIKit
import Firebase


class DeliveryAddressVC: UIViewController {
    
    //MARK: - Properties
    var deliveryAddress: DeliveryAddress?
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let pageTitleLabel = SFLabel(texxt: DELIVER_TXT.title,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    
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
    
    
    
    //Address Fields
    private let apartmentNumberTextField = SFTextField(placeHolder: DELIVER_TXT.house, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    private let addressLineOneTextField = SFTextField(placeHolder: DELIVER_TXT.add1, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    private let addressLineTwoTextField = SFTextField(placeHolder: DELIVER_TXT.add2, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    private let streetNumberTextField = SFTextField(placeHolder: DELIVER_TXT.street, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    private let cityNameTextField = SFTextField(placeHolder: DELIVER_TXT.city, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    private let stateNameTextField = SFTextField(placeHolder: DELIVER_TXT.state, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    private let zipCodeTextField = SFTextField(placeHolder: DELIVER_TXT.zip, autoCapital: .none, autoCorrect: .no, isSecure: false, height: 45)
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .secondarySystemBackground
        label.textColor = .label
        label.text = POST_PRODUCT_TEXTS.NO_COUNTRY
        label.textAlignment = .center
        label.setHeight(height: CONST.BUTTON_HEIGHT)
        label.layer.cornerRadius = CONST.CORNER_RADII
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.font = UIFont(name: Font.menlo, size: 16)
        return label
    }()
    private let countryTitleLabel = SFLabel(texxt: DELIVER_TXT.choose,
                                                         fontName: Font.menlo,
                                                         fontSize: 14, noOfLines: 0, texxtColor: .secondaryLabel, texxtAlignment: .left)
    
    
    private let updateAddressButton: SFButton = {
        let button = SFButton(placeHolder: DELIVER_TXT.update)
        button.addTarget(self, action: #selector(handleUpdateButtonTap), for: .touchUpInside)
        return button
    }()
    
    
    
    //For Bottom Sheet
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
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchDeliverAddress()
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
    
    
    
    
    
    /// Handles Country Label Tap
    @objc private func handleCountryLabelTap() {
        generateFeedback()
        print("DEBUG: Choose Country Here")
        showBottomSheet()
    }
    
    
    
    
    
    
    /// Handles Update Address Button Tap
    @objc private func handleUpdateButtonTap() {
        generateFeedback()
        print("DEBUG: Update Delivery Address Here")
        updateDeliverAddress()
    }
    
    
    
    
    
    
    
}
//MARK: - Extensions
extension DeliveryAddressVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
        view.addSubview(scrollView)
        
        
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
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
        
        //add Things to Stack View Now...
        stackView.addArrangedSubview(apartmentNumberTextField)
        apartmentNumberTextField.delegate = self
        stackView.addArrangedSubview(addressLineOneTextField)
        addressLineOneTextField.delegate = self
        stackView.addArrangedSubview(addressLineTwoTextField)
        addressLineTwoTextField.delegate = self
        stackView.addArrangedSubview(streetNumberTextField)
        streetNumberTextField.delegate = self
        stackView.addArrangedSubview(countryTitleLabel)
        stackView.addArrangedSubview(countryLabel)
        countryLabel.text = POST_PRODUCT_TEXTS.NO_COUNTRY
        let countryTap = UITapGestureRecognizer(target: self, action: #selector(handleCountryLabelTap))
        countryLabel.addGestureRecognizer(countryTap)
        stackView.addArrangedSubview(stateNameTextField)
        stateNameTextField.delegate = self
        stackView.addArrangedSubview(cityNameTextField)
        cityNameTextField.delegate = self
        stackView.addArrangedSubview(zipCodeTextField)
        zipCodeTextField.delegate = self
        zipCodeTextField.keyboardType = .numberPad
        stackView.addArrangedSubview(updateAddressButton)
        setupShadowToButton(button: updateAddressButton)
    }
    
    
}



//MARK: - TextField Delegate
extension DeliveryAddressVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}




extension DeliveryAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    //TABLE VIEW DELEGATES & DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bottomSheetTableView.dequeueReusableCell(withIdentifier: CategoryListCell.identifier, for: indexPath) as! CategoryListCell
        cell.selectionStyle = .none
        cell.categoryNameLabel.text = countryListArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClickTransparentView()
        countryLabel.text = countryListArray[indexPath.row]
    }
    
    
    
    /// Animates the Bottom Sheet in the View Controller
    private func showBottomSheet() {
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = view.frame
        view.addSubview(transparentView)
        //table view
        let screenSize = UIScreen.main.bounds.size
        let screenHeight = view.frame.size.height/2
        bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenHeight)
        //height = 250 because 5 cells of size 50
        view.addSubview(bottomSheetTableView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        //Animate in the tableview
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height-screenHeight, width: screenSize.width, height: screenHeight)
        }, completion: nil)
    }
    
    
    
    
    
    /// Selectors of Transparent View Tap Gesture, Animates out the View and Table View
    @objc private func onClickTransparentView() {
        let screenHeight = view.frame.size.height/2
        let screenSize = UIScreen.main.bounds.size
        //Animate the tableview out of screen
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.generateFeedback()
            self.transparentView.alpha = 0
            self.bottomSheetTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenHeight)
        }, completion: nil)
    }
    
}



//MARK: - API
extension DeliveryAddressVC {
    
    
    
    
    /// Updates the delivery address in firebase
    private func updateDeliverAddress() {
        
        guard let houseNumber = apartmentNumberTextField.text, !houseNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let addressLineOne = addressLineOneTextField.text, !addressLineOne.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let addressLineTwo = addressLineTwoTextField.text,
              let streetNumber = streetNumberTextField.text, !streetNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let country = countryLabel.text, country != POST_PRODUCT_TEXTS.NO_COUNTRY,
              let state = stateNameTextField.text, !state.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let city = cityNameTextField.text, !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let zipCode = zipCodeTextField.text, !zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: DELIVER_TXT.fieldMissing, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            view.addSubview(popUp)
            return
        }
        let dictionary = [DELIVER_ADDRESS.apartmentOrHouseNumber: houseNumber,
                          DELIVER_ADDRESS.addressLineOne: addressLineOne,
                          DELIVER_ADDRESS.addressLineTwo: addressLineTwo,
                          DELIVER_ADDRESS.streetNumber: streetNumber,
                          DELIVER_ADDRESS.country: country,
                          DELIVER_ADDRESS.state: state,
                          DELIVER_ADDRESS.city: city,
                          DELIVER_ADDRESS.zipCode: zipCode] as [String: AnyObject]
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.updateUsersDeliverAddress(with: currentUid, dictionary: dictionary, completion: { updated in
            if updated {
                print("DEBUG: Delivery Address was updated successfully")
                let popUp = CustomPopUp(popupTitle: DELIVER_TXT.updatedTitle, popupSubtitle: DELIVER_TXT.updatedMSG, customImage: #imageLiteral(resourceName: "icons8-grinning-face-with-big-eyes-48"))
                self.view.addSubview(popUp)
            } else {
                let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: DELIVER_TXT.failedMSG, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                self.view.addSubview(popUp)
                print("DEBUG: Failed to update deliver address")
            }
        })
    }
    
    
    
    
    
    
    /// Fetches Address From Firebase and sets to the textfields
    private func fetchDeliverAddress() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        
        DELIVERY_ADD_REF.child(currentUid).observe(.value, with: { snapshot in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let address = DeliveryAddress(dictionary: dictionary)
            self.deliveryAddress = address
            
            guard let house = address.apartmentOrHouseNumber,
                  let lineOne = address.addressLineOne,
                  let lineTwo = address.addressLineTwo,
                  let streetNumber = address.streetNumber,
                  let country = address.country,
                  let state = address.state,
                  let city = address.city,
                  let zipCode = address.zipCode else { return }
            
            self.apartmentNumberTextField.text = house
            self.addressLineOneTextField.text = lineOne
            self.addressLineTwoTextField.text = lineTwo
            self.streetNumberTextField.text = streetNumber
            self.countryLabel.text = country
            self.stateNameTextField.text = state
            self.cityNameTextField.text = city
            self.zipCodeTextField.text = zipCode
        })
    }
    
    
    
    
    
    
    
    
    
}

