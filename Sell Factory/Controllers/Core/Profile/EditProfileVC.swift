//
//  EditProfileVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit
import Firebase


class EditProfileVC: UIViewController {
    
    //MARK: - Properties
    var profileImage: UIImage?
    var user: User?
    var profileImageDownloadURL: String?
    
    private let pageTitleLabel = SFLabel(texxt: EDITPROFILE.PAGE_TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //Profile Picture
    private let editProfileImageView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(systemName: SFSYMBOLS.PLUS_IMAGE)
         iv.tintColor = COLORS.customLavender
         iv.setDimensions(height: 35, width: 35)
         iv.contentMode = .scaleAspectFit
         return iv
     }()
     
     private let profileImageView = SFImageView(bgColor: .secondaryLabel,
                                                contentmode: .scaleAspectFit,
                                                clipsTobounds: true,
                                                isInteractable: true,
                                                dim: 100)

    private let usernameLabel = SFLabel(texxt: EDITPROFILE.USERNAME,
                                        fontName: Font.menlo,
                                        fontSize: 16,
                                        noOfLines: 1,
                                        texxtColor: COLORS.customLavender,
                                        texxtAlignment: .center)
    
    //other fields
    private let firstNameTextField = SFTextField(placeHolder: EDITPROFILE.FIRST_NAME, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    private let lastNameTextField = SFTextField(placeHolder: EDITPROFILE.LAST_NAME, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    private let nameStack = SFStackView(stackAxis: .horizontal, stackSpace: 10)
    private let bioTextField = SFTextField(placeHolder: EDITPROFILE.BIO, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    private let countryTextField = SFTextField(placeHolder: EDITPROFILE.COUNTRY, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    private let emailIDTextField = SFTextField(placeHolder: EDITPROFILE.EMAIL, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    private let contactNumberTextField = SFTextField(placeHolder: EDITPROFILE.Phone, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    
    
    private let updateBioButton: SFButton = {
        let button = SFButton(placeHolder: EDITPROFILE.UPDATEBIO)
        button.addTarget(self, action: #selector(handleUpdateBioButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    init(image: UIImage, user: User) {
        super.init(nibName: nil, bundle: nil)
        self.profileImage = image
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG: Edit Profile VC")
        configureUI()
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Configures Basic UI of the View Controller
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
        setupUserDetails()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    /// Handles Profile Image Tap Gesture
    @objc private func handleProfileImageTapped() {
        generateFeedback()
        print("DEBUG: Handle Profile Image Tap Here")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    
    
    /// Handles Profile Image Tap Gesture
    @objc private func handleUpdateBioButtonTapped() {
        generateFeedback()
        print("DEBUG: Handle Update Bio Button Tap Here")
        saveChangesToProfile()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extension



//ARK: - Configure View Extension
extension EditProfileVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(pageTitleLabel)
        view.addSubview(backButton)
        view.addSubview(profileImageView)
        view.addSubview(editProfileImageView)
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
        
        //profile imageview
        profileImageView.centerX(inView: view)
        profileImageView.anchor(top: pageTitleLabel.bottomAnchor,
                                paddingTop: 25)
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(profileImageTap)
        editProfileImageView.anchor(bottom: profileImageView.bottomAnchor,
                                    right: profileImageView.rightAnchor)
        
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scrollView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20).isActive = true;
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
        
        //add to stack view
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(nameStack)
        nameStack.addArrangedSubview(firstNameTextField)
        nameStack.addArrangedSubview(lastNameTextField)
        nameStack.distribution = .fillEqually
        stackView.addArrangedSubview(emailIDTextField)
        emailIDTextField.isUserInteractionEnabled = false
        stackView.addArrangedSubview(bioTextField)
        stackView.addArrangedSubview(countryTextField)
        stackView.addArrangedSubview(contactNumberTextField)
        stackView.addArrangedSubview(updateBioButton)
    }
    
    
    
}



//MARK: - Extensions
extension EditProfileVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profileImageView.image = profileImage
        updateProfilePicture(image: profileImage)
        self.dismiss(animated: true, completion: nil)
    }
}





//MARK: - Extensions
//MARK: - API
extension EditProfileVC {
    
    
    
    /// Fetches User Details from Database and sets the Details
    private func setupUserDetails() {
        guard let firstName = user?.firstName,
              let lastName = user?.lastName,
              let emailId = user?.emailID,
              let bio = user?.bio,
              let country = user?.country,
              let phoneNumber = user?.phoneNumber else { return }
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        bioTextField.text = bio
        emailIDTextField.text = emailId
        countryTextField.text = country
        contactNumberTextField.text = phoneNumber
        usernameLabel.text = "@\(firstName.lowercased())"
        profileImageView.image = profileImage
    }
    
    
    
    
    
    /// Updates the profile Image in Storage and Database
    /// - Parameter image: uiimage
    private func updateProfilePicture(image: UIImage) {
        guard let currenUser = Auth.auth().currentUser?.uid else { return }
        guard let oldFileName = user?.profileImageFileName else { return }
        //filename
        let result = DatabaseManager.safeDate(date: Date())
        guard let image = profileImageView.image,
              let data = image.pngData() else { return }
        let id = NSUUID().uuidString
        let fileName = "profile_picture_\(id)_\(result)"
        //delete older picture first
        DatabaseManager.shared.deleteOlderProfilePicture(with: oldFileName, completion: { done in
            if done {
                print("DEBUG: Older Picture deleted Successfully")
                //Update new Picture
                DatabaseManager.shared.uploadPicture(with: data, fileName: fileName, completion: { result in
                    switch result {
                    case .success(let downloadURL):
                        self.profileImageDownloadURL = downloadURL
                        let popUp = CustomPopUp(popupTitle: POPUP.SUCCESS, popupSubtitle: POPUP.SUCCESS_MSG, customImage: #imageLiteral(resourceName: "icons8-grinning-face-with-big-eyes-48"))
                        self.view.addSubview(popUp)
                        USER_REF.child(currenUser).child(USER.profileImageFileName).setValue(fileName)
                        USER_REF.child(currenUser).child(USER.profileImageURL).setValue(downloadURL)
                    //delete older picture
                    case .failure(let error):
                        let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.PROFILE_IMG_UPDATE_FAILED_MSG+" Error: \(error.localizedDescription)", customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                        self.view.addSubview(popUp)
                    }
                })
            } else {
                print("DEBUG: Failed to Delete Older Profile Picture")
            }
        })
    }
    
    
    
    
    /// Updates Profile of The Current Logged In User
    private func saveChangesToProfile() {
        guard let fn = firstNameTextField.text,
              let ln = lastNameTextField.text,
              let country = countryTextField.text,
              let phone = contactNumberTextField.text,
              let bio = bioTextField.text else { return }
        DatabaseManager.shared.updateUserProfile(firstname: fn, lastname: ln, bio: bio, country: country, phoneNumber: phone, completion: { completed in
            if completed {
                //updated
                let popUp = CustomPopUp(popupTitle: POPUP.SUCCESS, popupSubtitle: POPUP.BIO_UPDATED_MSG, customImage: #imageLiteral(resourceName: "icons8-grinning-face-with-big-eyes-48"))
                self.view.addSubview(popUp)
            } else {
                //failed
                let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.BIO_UPDATED_FAILED_MSG, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                self.view.addSubview(popUp)
            }
        })
    }
    
    
    
    
    
    
    
    
}
