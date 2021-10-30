//
//  NotificationsCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/6/21.
//

import UIKit
import SDWebImage


class NotificationsCell: UITableViewCell {

    //MARK: - Properties
    
    var notification: Notifications? {
        
        didSet {
            guard let notificationMsg = notification?.notificationType.description else { return }
            
            guard let productName = notification?.product?.productName,
                  let username = notification?.user.firstName else { return }
            
            guard let uid = notification?.user.uid else { return }
            let currentUid = DatabaseManager.getCurrentUid()
            
            if currentUid == uid {
                usernameLabel.text = "By \(username)"
            } else {
                usernameLabel.text = "To \(username)"
            }
            
            notificationTitle.text = "\(productName)\(notificationMsg)"
            
            
            if let product = notification?.product {
                let imgURL = URL(string: product.coverImageURL)
                productCoverImage.sd_setImage(with: imgURL, completed: nil)
            }
        }
        
    }
    
    
    
    static let identifier = "NotificationsCell"
    
    
    
    lazy var productCoverImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderColor = COLORS.customLavender.cgColor
        iv.layer.borderWidth = 1.2
        return iv
    }()
    
    
    lazy var notificationTitle = SFLabel(texxt: "",
                                            fontName: Font.menloBold,
                                            fontSize: 12,
                                            noOfLines: 0,
                                            texxtColor: .label,
                                            texxtAlignment: .left)
    
    lazy var usernameLabel = SFLabel(texxt: "",
                                     fontName: Font.menlo,
                                     fontSize: 12,
                                     noOfLines: 1,
                                     texxtColor: .secondaryLabel,
                                     texxtAlignment: .left)
    
    
    
    
    
    
    
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productCoverImage)
        addSubview(notificationTitle)
        addSubview(usernameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imgDim = (contentView.frame.size.height)-10
        productCoverImage.anchor(top: contentView.topAnchor,
                                 left: contentView.leftAnchor,
                                 bottom: contentView.bottomAnchor,
                                 right: nil,
                                 paddingTop: 5,
                                 paddingLeft: 15,
                                 paddingBottom: 5,
                                 paddingRight: 0)
        productCoverImage.setDimensions(height: imgDim, width: imgDim)
        
        
        notificationTitle.centerY(inView: productCoverImage)
        notificationTitle.anchor(left: productCoverImage.rightAnchor,
                                 right: contentView.rightAnchor,
                                 paddingLeft: 8,
                                 paddingRight: 15)
        
        usernameLabel.anchor(top: notificationTitle.bottomAnchor,
                             left: productCoverImage.rightAnchor,
                             bottom: nil,
                             right: contentView.rightAnchor,
                             paddingTop: 5,
                             paddingLeft: 15,
                             paddingRight: 15)
        
    }
    
    
    
    
    

}
