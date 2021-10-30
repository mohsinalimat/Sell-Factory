//
//  ChatController.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/7/21.
//

import Foundation
import UIKit
import Firebase

class ChatController: UIViewController {
    
    
    //MARK: - Properties
    var user: User?
    var messages = [Message]()
    
    
    private let topNavigationView: UIView = {
        let view = UIView()
        view.backgroundColor = COLORS.customLavender
        return view
    }()
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    private let chatTitleLabel = SFLabel(texxt: "",
                                         fontName: Font.menloBold,
                                         fontSize: 16,
                                         noOfLines: 1,
                                         texxtColor: .black,
                                         texxtAlignment: .center)
    
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    
    
    lazy var containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = COLORS.customLavender
        cv.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        cv.addSubview(messageTextField)
        messageTextField.anchor(top: cv.topAnchor,
                                left: cv.leftAnchor,
                                bottom: cv.bottomAnchor,
                                right: cv.rightAnchor,
                                paddingTop: 0,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 58,
                                width: 0,
                                height: 0)
        messageTextField.delegate = self
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.tintColor = UIColor.black
        sendButton.backgroundColor = COLORS.customLavender
        sendButton.titleLabel?.font = UIFont(name: Font.menloBold, size: 14)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        cv.addSubview(sendButton)
        sendButton.anchor(top: cv.topAnchor,
                          left: nil,
                          bottom: cv.bottomAnchor,
                          right: cv.rightAnchor,
                          paddingRight: 12)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        cv.addSubview(separatorView)
        separatorView.anchor(top: cv.topAnchor,
                             left: cv.leftAnchor,
                             bottom: nil,
                             right: cv.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 0.5)
        
        return cv
    }()

    let messageTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Message", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        tf.textColor = .black
        tf.font = UIFont(name: Font.menlo, size: 16)
        tf.backgroundColor = COLORS.customLavender
        let spacer = UIView()
        spacer.setDimensions(height: 60, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        return tf
    }()
    
    
    
    
    
    
    
    
    //MARK: - Init
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        guard let name = user?.firstName,
              let ln = user?.lastName else { return }
        chatTitleLabel.text = "\(name) \(ln)"
        
        //looks for messages...
        observeMessages()
    }
    
    
    
    
    //MARK: - Helpers
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        
        configureViews()
    }
    
    
    
    
    
    
    private func configureViews() {
        //add sub view
        view.addSubview(topNavigationView)
        view.addSubview(collectionView)
        view.addSubview(chatTitleLabel)
        view.addSubview(backButton)
        
        
        //layout views
        topNavigationView.anchor(top: view.topAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor)
        topNavigationView.setHeight(height: 90)
        
        chatTitleLabel.anchor(top: nil,
                              left: topNavigationView.leftAnchor,
                              bottom: topNavigationView.bottomAnchor,
                              right: topNavigationView.rightAnchor,
                              paddingLeft: 15,
                              paddingBottom: 15,
                              paddingRight: 15)
        
        
        collectionView.anchor(top: topNavigationView.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 5)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        backButton.centerY(inView: chatTitleLabel)
        backButton.anchor(left: view.leftAnchor,
                          paddingLeft: 15)
    }
    
    
    
    
    
    
    
    /// Returns dynamic size for text bubbles
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options,
                                                   attributes: [NSAttributedString.Key.font: UIFont(name: Font.menlo, size: 16)!],
                                                   context: nil)
    }
    
    
    
    
    ///Configures chat bubble
    private func configureMessage(cell: ChatCell, message: Message) {
        let currentUid = DatabaseManager.getCurrentUid()
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(message.messageText).width + 32
        cell.frame.size.height = estimateFrameForText(message.messageText).height + 20
        
        //check if message is from current user
        if message.fromID == currentUid {
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleView.backgroundColor = COLORS.customLavender
            cell.textView.textColor = .black
            cell.profileImageView.isHidden = true
        } else {
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleView.backgroundColor = .clear
            cell.textView.textColor = .label
            cell.bubbleView.layer.borderWidth = 1.2
            cell.bubbleView.layer.borderColor = UIColor.darkGray.cgColor
            cell.profileImageView.isHidden = false
        }
        
    }
    
    
    
    
    
    
    
    //MARK: - Selectors

    
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func handleSend() {
        generateFeedback()
        print("DEBUG: Handle Send here")
        uploadMessageToServer()
    }
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extensions


//MARK: - Collection Views
extension ChatController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        let message = messages[indexPath.item]
        height = estimateFrameForText(message.messageText).height + 20
        return CGSize(width: view.frame.width, height: height)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        cell.message = messages[indexPath.item]
        configureMessage(cell: cell, message: messages[indexPath.item])
        return cell
    }
    
    
}



//MARK: - API
extension ChatController {
    
    private func uploadMessageToServer() {
        let currentUid = DatabaseManager.getCurrentUid()
        guard let user = self.user else { return }
        guard let toID = user.currenUid else { return }
        guard let messageText = messageTextField.text, !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            let popUp = CustomPopUp(popupTitle: POPUP.OOPS, popupSubtitle: "Please enter a message to send and not blank spaced", customImage: #imageLiteral(resourceName: "icons8-sad-but-relieved-face-48"))
            self.view.addSubview(popUp)
            return
        }
        
        DatabaseManager.shared.sendMessages(from: currentUid, to: toID, message: messageText, completion: { sent in
            if sent {
                self.messageTextField.text = nil
                print("DEBUG: Sent")
            } else {
                print("DEBUG: Failed to send")
            }
        })
    }
    
    
    
    
    private func observeMessages() {
        let currentUid = DatabaseManager.getCurrentUid()
        guard let chatPartnerID = self.user?.currenUid else { return }
        
        USER_MESSAGES_REF.child(currentUid).child(chatPartnerID).observe(.childAdded, with: { snapshot in
            let messageId = snapshot.key
            DatabaseManager.shared.fetchMessage(with: messageId, completion: { message in
                self.messages.append(message)
                self.messages.sort { msg1, msg2 in
                    return msg2.creationDate > msg1.creationDate
                }
                self.collectionView.reloadData()
            })
        })
        
    }
    
    
    
}



//MARK: - TextField Delegate
extension ChatController: UITextFieldDelegate {
    
    /// Dismisses keyboard on return key tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        messageTextField.resignFirstResponder()
        return false
    }
}
