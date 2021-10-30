//
//  MessagesCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/7/21.
//

import UIKit
import Firebase
import SDWebImage

class MessagesCell: UITableViewCell {
    //MARK: - Properties
    
    var message: Message? {
        didSet {
            guard let messageText = message?.messageText else { return }
            detailTextLabel?.text = messageText
            
            
            if let seconds = message?.creationDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                timeStampLabel.text = dateFormatter.string(from: seconds)
            }
            
            
            //configure user data
            configureUserData()
            
        }
    }
    
    
    static let identifier = "MessagesCell"

    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = COLORS.customLavender.cgColor
        iv.layer.borderWidth = 1.2
        return iv
    }()
    
    
    
    let timeStampLabel = SFLabel(texxt: "",
                                 fontName: Font.menlo,
                                 fontSize: 12,
                                 noOfLines: 1,
                                 texxtColor: .darkGray,
                                 texxtAlignment: .right)
    
    
    
    
    
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(profileImageView)
        addSubview(timeStampLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: - Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.anchor(top: nil,
                                left: leftAnchor,
                                bottom: nil,
                                right: nil,
                                paddingTop: 0,
                                paddingLeft: 15,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 50,
                                height: 50)
        profileImageView.layer.cornerRadius = 50/2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        timeStampLabel.anchor(top: topAnchor,
                              left: nil,
                              bottom: nil,
                              right: rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 10)
        
        textLabel?.frame = CGRect(x: 68, y: textLabel!.frame.origin.y-2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 68, y: detailTextLabel!.frame.origin.y+2, width: self.frame.width-108, height: detailTextLabel!.frame.height)
        
        textLabel?.font = UIFont(name: Font.menloBold, size: 14)
        detailTextLabel?.font = UIFont(name: Font.menlo, size: 12)
        
        textLabel?.textColor = .label
        detailTextLabel?.textColor = .secondaryLabel

    }
    
    
    
    //MARK: - Helper
    func configureUserData() {
        
        guard let chatPartnerID = message?.getChatPartnerID() else { return }
        
        DatabaseManager.shared.fetchUser(with: chatPartnerID, completion: { user in
            
            guard let imgURL = user.profileImageURL,
                  let fn = user.firstName,
                  let ln = user.lastName else { return }
            let url = URL(string: imgURL)
            self.profileImageView.sd_setImage(with: url, completed: nil)
            self.textLabel?.text = "\(fn) \(ln)"
        })
    }
    
}
