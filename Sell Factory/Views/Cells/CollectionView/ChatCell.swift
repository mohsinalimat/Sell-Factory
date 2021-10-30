//
//  ChatCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/7/21.
//

import UIKit
import Firebase
import SDWebImage

class ChatCell: UICollectionViewCell {
    //MARK: - Properties
    
    var message: Message? {
        didSet {
            
            guard let messageText = message?.messageText else { return }
            textView.text = messageText
            
            guard let chatPartnerID = message?.getChatPartnerID() else { return }
            DatabaseManager.shared.fetchUser(with: chatPartnerID, completion: { user in
                guard let profileImageURL = user.profileImageURL else { return }
                let url = URL(string: profileImageURL)
                self.profileImageView.sd_setImage(with: url, completed: nil)
            })
            
        }
    }
    
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    
    static let identifier = "ChatCell"
    
    
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = COLORS.customLavender
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Text for now"
        tv.font = UIFont(name: Font.menlo, size: 16)
        tv.backgroundColor = .clear
        tv.textColor = .black
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImageView)
        
        
        profileImageView.anchor(top: nil,
                                left: leftAnchor,
                                bottom: bottomAnchor,
                                right: nil,
                                paddingTop: 0,
                                paddingLeft: 8,
                                paddingBottom: -4,
                                paddingRight: 0,
                                width: 32,
                                height: 32)
        profileImageView.layer.cornerRadius = 32/2
        
        
        
        //bubble view right anchor
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        
        //bubble view left anchor
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        bubbleViewLeftAnchor?.isActive = false
        
        //bubble view width and top anchor
        bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        
        //bubble view height anchor
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        //textview anchors
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
