//
//  ForgotPasswordVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    //MARK: - Properties
    private let titleLabel = TitleLabel(name: TXT.APP_TITLE)
    
    private let emailTF = SFTextField(placeHolder: TXT.EMAIL, autoCapital: .none, autoCorrect: .no, isSecure: false, height: CONST.TF_HEIGHT)
    
    private let stackView = SFStackView(stackAxis: .vertical, stackSpace: 10)
    
    private let resetPasswordButton: SFButton = {
        let button = SFButton(placeHolder: TXT.RESET_PASS)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let remeberPasswordButton: SFAttributedButton = {
        let button = SFAttributedButton(titleOne: TXT.REMEMBER_PASS, titleTwo: TXT.LOGIN)
        button.addTarget(self, action: #selector(handleRememberPassword), for: .touchUpInside)
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    /// Get user Email ID and Send Reset Link
    @objc private func handleResetPassword() {
        generateFeedback()
        print("DEBUG: Send Reset Link Here")
    }
    
    
    
    /// Goes back to Login View Controller
    @objc private func handleRememberPassword() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
}


//MARK: - Extensions

//MARK: - TextField Delegate
extension ForgotPasswordVC: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


//MARK: - Configure View Extension
extension ForgotPasswordVC {
    
    
    
    /// Configures Views of this View Controller
    private func configureViews() {
        //add sub views
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTF)
        stackView.addArrangedSubview(resetPasswordButton)
        view.addSubview(titleLabel)
        view.addSubview(remeberPasswordButton)
        
        //layout views
        stackView.centerY(inView: view)
        stackView.anchor(left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 15,
                         paddingRight: 15)
        
        emailTF.delegate = self
        
        titleLabel.anchor(top: nil,
                          left: stackView.leftAnchor,
                          bottom: stackView.topAnchor,
                          right: stackView.rightAnchor,
                          paddingBottom: 25)
        
        remeberPasswordButton.anchor(top: nil,
                                   left: view.leftAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   right: view.rightAnchor,
                                   paddingLeft: 15,
                                   paddingBottom: 15,
                                   paddingRight: 15)
        
        
    }
    
    
}
