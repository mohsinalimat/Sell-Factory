//
//  RegisterVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import UIKit

class RegisterVC: UIViewController {
    
    //MARK: - Properties
    var isImageSelected: Bool = false
    
    private let titleLabel = TitleLabel(name: TXT.APP_TITLE)
    
    private let firstNameTF = SFTextField(placeHolder: TXT.FIRST_NAME, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    
    private let lastNameTF = SFTextField(placeHolder: TXT.LAST_NAME, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    
    private let emailTF = SFTextField(placeHolder: TXT.EMAIL, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    
    private let passwordTF = SFTextField(placeHolder: TXT.PASSWORD, autoCapital: .none, autoCorrect: .no, isSecure: true, height: CONST.TF_HEIGHT)
    
    private let stackView = SFStackView(stackAxis: .vertical, stackSpace: 10)
    
    private let nameStackView = SFStackView(stackAxis: .horizontal, stackSpace: 10)
    
    private let plusPhotoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: SFSYMBOLS.PLUS_IMAGE)
        iv.tintColor = COLORS.customLavender
        iv.setDimensions(height: 30, width: 30)
        iv.clipsToBounds = true
        return iv
    }()
    
    private let signUpButton: SFButton = {
        let button = SFButton(placeHolder: TXT.SIGNUP)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: SFAttributedButton = {
        let button = SFAttributedButton(titleOne: TXT.ALREADY_AC, titleTwo: TXT.LOGIN)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView = SFImageView(bgColor: .secondarySystemBackground,
                                               contentmode: .scaleAspectFit,
                                               clipsTobounds: true,
                                               isInteractable: true,
                                               dim: 120)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    /// Goes back to Login View Controller
    @objc private func handleLogin() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    /// Handles Profile Image Tap
    @objc private func didTapProfilePicture() {
        generateFeedback()
        print("DEBUG: Handle Profile Picture Here")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    
    
    
    /// Signs up user and sends to Home Screen
    @objc private func handleSignUp() {
        generateFeedback()
        signUpUser()
    }
    
    
    
    
    
    
    
    
}



//MARK: - Extensions

//MARK: - TextField Delegate
extension RegisterVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


//MARK: - Configure View Extension
extension RegisterVC {
    
    
    
    /// Configures Views of this View Controller
    private func configureViews() {
        //add sub views
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameStackView)
        nameStackView.addArrangedSubview(firstNameTF)
        nameStackView.addArrangedSubview(lastNameTF)
        nameStackView.distribution = .fillEqually
        stackView.addArrangedSubview(emailTF)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(signUpButton)
        view.addSubview(alreadyHaveAccountButton)
        view.addSubview(profileImageView)
        view.addSubview(plusPhotoImage)
        view.addSubview(titleLabel)
        
        //layout views
        stackView.centerY(inView: view)
        stackView.anchor(left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 15,
                         paddingRight: 15)
        
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        alreadyHaveAccountButton.anchor(top: nil,
                                        left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor,
                                        paddingLeft: 15,
                                        paddingBottom: 15,
                                        paddingRight: 15)
        
        profileImageView.centerX(inView: view)
        profileImageView.anchor(bottom: stackView.topAnchor,
                                paddingBottom: 25)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePicture))
        profileImageView.addGestureRecognizer(tap)
        
        
        plusPhotoImage.anchor(top: nil,
                              left: nil,
                              bottom: profileImageView.bottomAnchor,
                              right: profileImageView.rightAnchor)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: profileImageView.topAnchor,
                        right: view.rightAnchor,
                        paddingTop: 10,
                        paddingLeft: 15,
                        paddingBottom: 15,
                        paddingRight: 15)
    }
    
    
    
    
    
}



//MARK: - UIIMage Picker Delegate
extension RegisterVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profileImageView.image = profileImage
        isImageSelected = true
        self.dismiss(animated: true, completion: nil)
    }
}




//MARK: - API

extension RegisterVC {
    
    private func signUpUser() {
        
        guard let email = emailTF.text, !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let password = passwordTF.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let firstName = firstNameTF.text, !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let lastName = lastNameTF.text, !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.MISSING_FIELDS, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            view.addSubview(popUp)
            return
        }
        
        if isImageSelected == false {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.MISSING_FIELDS, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            view.addSubview(popUp)
        } else {
            print("DEBUG: Sign up User")
            guard let profileImage = profileImageView.image else { return }
            DatabaseManager.shared.createUser(with: firstName, lastName: lastName, emailId: email, password: password, profileImage: profileImage, completion: { done in
                if done {
                    //signed up...go to home screen
                    let vc = UINavigationController(rootViewController: HomeVC())
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                } else {
                    //failed
                    let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.SIGNUP_ERROR, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                    self.view.addSubview(popUp)
                }
            })
        }
        
    }
    
}
