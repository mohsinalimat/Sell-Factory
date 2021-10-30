//
//  MessagesVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit
import Firebase


class MessagesVC: UIViewController {
    
    //MARK: - Properties
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let pageTitleLabel = SFLabel(texxt: MESSAGES_TEXTS.PAGE_TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.register(MessagesCell.self, forCellReuseIdentifier: MessagesCell.identifier)
        return tv
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG: Settings VC")
        configureUI()
        fetchMessages()
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
extension MessagesVC {
    
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
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 5,
                         paddingLeft: 5,
                         paddingBottom: 0,
                         paddingRight: 5)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    

    
    

    
    
    
}



//MARK: - UITable View Delegate, DataSource
extension MessagesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessagesCell.identifier, for: indexPath) as! MessagesCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: Did Select Row")
        let message = messages[indexPath.row]
        let chatPartnerID = message.getChatPartnerID()
        DatabaseManager.shared.fetchUser(with: chatPartnerID, completion: { user in
            self.navigationController?.pushViewController(ChatController(user: user), animated: true)
        })
    }
    
    
}


//MARK: - API
extension MessagesVC {
    
    
    
    
    /// Fetches messages for current user
    private func fetchMessages() {
        let currentUid = DatabaseManager.getCurrentUid()
        
        self.messages.removeAll()
        self.messagesDictionary.removeAll()
        self.tableView.reloadData()
        
        USER_MESSAGES_REF.child(currentUid).observe(.childAdded, with: { snapshot in
            let uid = snapshot.key
            USER_MESSAGES_REF.child(currentUid).child(uid).observe(.childAdded, with: { snapshot in
                let messageID = snapshot.key
                DatabaseManager.shared.fetchMessage(with: messageID, completion: { message in
                    let chatPartnerID = message.getChatPartnerID()
                    self.messagesDictionary[chatPartnerID] = message
                    self.messages = Array(self.messagesDictionary.values)
                    self.tableView.reloadData()
                })
            })
        })
    }
    
    
    
    
}
