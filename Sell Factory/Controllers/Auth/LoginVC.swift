//
//  LoginVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - Properties
    private let titleLabel = TitleLabel(name: TXT.APP_TITLE)
    
    private let emailTF = SFTextField(placeHolder: TXT.EMAIL, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    
    private let passwordTF = SFTextField(placeHolder: TXT.PASSWORD, autoCapital: .none, autoCorrect: .no, isSecure: true, height: CONST.TF_HEIGHT)
    
    private let stackView = SFStackView(stackAxis: .vertical, stackSpace: 10)
    
    private let loginButton: SFButton = {
        let button = SFButton(placeHolder: TXT.LOGIN)
        button.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let createAccountButton: SFAttributedButton = {
        let button = SFAttributedButton(titleOne: TXT.DONT_HAVE_AC, titleTwo: TXT.SIGNUP)
        button.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TXT.FORGOT_PASS, for: .normal)
        button.tintColor = .secondaryLabel
        button.titleLabel?.font = UIFont(name: Font.menlo, size: 16)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
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
        //remove from navigation stack
        navigationController?.removeViewController(SettingsVC.self)
        navigationController?.removeViewController(ProfileVC.self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    /// Goes to Register View Controller
    @objc private func handleCreateAccount() {
        generateFeedback()
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    
    
    
    
    
    /// Goes to Forgot Password View Controller
    @objc private func handleForgotPassword() {
        generateFeedback()
        navigationController?.pushViewController(ForgotPasswordVC(), animated: true)
    }
    
    
    
    
    
    /// Handles Login Button Tap
    @objc private func handleLoginButtonTapped() {
        generateFeedback()
        loginUser()
    }
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions

//MARK: - TextField Delegate
extension LoginVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


//MARK: - Configure View Extension
extension LoginVC {
    
    
    
    /// Configures Views of this View Controller
    private func configureViews() {
        //add sub views
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTF)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(forgotPasswordButton)
        view.addSubview(titleLabel)
        view.addSubview(createAccountButton)
        
        //layout views
        stackView.centerY(inView: view)
        stackView.anchor(left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 15,
                         paddingRight: 15)
        emailTF.delegate = self
        passwordTF.delegate = self
        
        
        titleLabel.anchor(top: nil,
                          left: stackView.leftAnchor,
                          bottom: stackView.topAnchor,
                          right: stackView.rightAnchor,
                          paddingBottom: 25)
        
        createAccountButton.anchor(top: nil,
                                   left: view.leftAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   right: view.rightAnchor,
                                   paddingLeft: 15,
                                   paddingBottom: 15,
                                   paddingRight: 15)
    }
    
    
}

//MARK: - Extension

//MARK: - API

extension LoginVC {
    
    private func loginUser() {
        guard let email = emailTF.text, !email.trimmingCharacters(in: .whitespaces).isEmpty,
              let password = passwordTF.text, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.MISSING_EMAIL_PASS, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            view.addSubview(popUp)
            return
        }
        
        DatabaseManager.shared.loginUser(with: email, password: password, completion: { done in
            if done {
                //logged in
                let vc = UINavigationController(rootViewController: HomeVC())
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            } else {
                let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: POPUP.LOGIN_ERROR, customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
                self.view.addSubview(popUp)
            }
        })
        
    }
    
    
}
