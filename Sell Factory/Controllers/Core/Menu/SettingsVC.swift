//
//  SettingsVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit

class SettingsVC: UIViewController {
    
    //MARK: - Properties
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let pageTitleLabel = SFLabel(texxt: SETTINGS_TEXTS.PAGE_TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.register(ProfileSettingsMenuCell.self, forCellReuseIdentifier: ProfileSettingsMenuCell.identifier)
        return tv
    }()
    
    
    var settingsArray = [SETTINGS_TEXTS.DELIVERY_ADDRESS,
                         SETTINGS_TEXTS.CONTACT,
                         SETTINGS_TEXTS.INVITE,
                         SETTINGS_TEXTS.PRIVACY,
                         SETTINGS_TEXTS.SECURITY,
                         SETTINGS_TEXTS.HELP,
                         SETTINGS_TEXTS.ABOUT,
                         SETTINGS_TEXTS.SIGNOUT]
    var settingsImageArray = [UIImage(systemName: SFSYMBOLS.DELIVERY_BOX),
                              UIImage(systemName: SFSYMBOLS.PHONE),
                              UIImage(systemName: SFSYMBOLS.TWO_PERSON),
                              UIImage(systemName: SFSYMBOLS.LOCK),
                              UIImage(systemName: SFSYMBOLS.SHIELD),
                              UIImage(systemName: SFSYMBOLS.CIRCLE_QUESTION),
                              UIImage(systemName: SFSYMBOLS.CIRCLE_EXCLAMATION),
                              UIImage(systemName: SFSYMBOLS.LOGOUT)]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG: Settings VC")
        configureUI()
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extension


//ARK: - Configure View Extension
extension SettingsVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
        view.addSubview(tableView)
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
        tableView.anchor(top: pageTitleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 15,
                         paddingLeft: 5,
                         paddingBottom: 0,
                         paddingRight: 5)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}


//MARK: - Extension

//MARK: - Table View Delegates and Data Source
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsMenuCell.identifier, for: indexPath) as! ProfileSettingsMenuCell
        cell.leftImageView.image = settingsImageArray[indexPath.row]
        cell.leftLabel.text = settingsArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            generateFeedback()
            print("DEBUG: Delivery Address")
            navigationController?.pushViewController(DeliveryAddressVC(), animated: true)
        case 1:
            generateFeedback()
            print("DEBUG: Contact Info")
            navigationController?.pushViewController(ContactInfoVC(), animated: true)
        case 2:
            generateFeedback()
            print("DEBUG: Invite Friends")
            navigationController?.pushViewController(InviteFriendsVC(), animated: true)
        case 3:
            generateFeedback()
            print("DEBUG: Privacy")
            navigationController?.pushViewController(PrivacyVC(), animated: true)
        case 4:
            generateFeedback()
            print("DEBUG: Security")
            navigationController?.pushViewController(SecurityVC(), animated: true)
        case 5:
            generateFeedback()
            print("DEBUG: Help")
            navigationController?.pushViewController(HelpVC(), animated: true)
        case 6:
            generateFeedback()
            print("DEBUG: About")
            navigationController?.pushViewController(AboutVC(), animated: true)
        case 7:
            generateFeedback()
            print("DEBUG: Logout Here")
            handleSignOut()
        default:
            print("DEBUG: Something went wrong")
            break
        }
    }
    
    
}


//MARK: - API

extension SettingsVC {
    
    
    
    
    /// Handles Sign Out
    private func handleSignOut() {
        popUpWithButtons(imgName: SFSYMBOLS.LOGOUT, btnYesText: "Yes", btnNoText: "No", yesButtonBGColor: .systemRed, noButtonBGColor: .systemGreen, viewBorderColor: COLORS.customLavender, txtMessage: "Are you sure you want to Logout?", numOfButtons: 2, completion: { yes in
            if yes {
                self.generateFeedback()
                DatabaseManager.shared.logoutCurrentUser(completion: { isLoggedOut in
                    if isLoggedOut {
                        //go to login screen
                        let vc = UINavigationController(rootViewController: LoginVC())
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
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
