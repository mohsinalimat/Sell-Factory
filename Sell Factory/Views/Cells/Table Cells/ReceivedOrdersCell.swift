//
//  ReceivedOrdersCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/5/21.
//

import Foundation
import UIKit
import SDWebImage
import Firebase


class ReceivedOrdersCell: UITableViewCell {
    
    //MARK: - Properties
    
    var receivedOrder: Notifications? {
        didSet {
            guard let name = receivedOrder?.product?.productName,
                  let fn = receivedOrder?.user.firstName,
                  let ln = receivedOrder?.user.lastName,
                  let profileURL = receivedOrder?.user.profileImageURL else { return }
            
            buyerName.text = "\(fn) \(ln)"
            productName.text = "Bought: \(name)"
            
            let url = URL(string: profileURL)
            DispatchQueue.main.async {
                self.buyerImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    
    
    
    static let identifier = "ReceivedOrdersCell"

    
    let buyerImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = COLORS.customLavender.cgColor
        iv.layer.borderWidth = 1.2
        return iv
    }()
    
    
    let buyerName = SFLabel(texxt: "",
                                    fontName: Font.menloBold,
                                    fontSize: 14,
                                    noOfLines: 0,
                                    texxtColor: .label,
                                    texxtAlignment: .left)
    
    let productName = SFLabel(texxt: "",
                                      fontName: Font.menlo,
                                      fontSize: 12,
                                      noOfLines: 0,
                                      texxtColor: .label,
                                      texxtAlignment: .left)


    
    
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(buyerImageView)
        addSubview(buyerName)
        addSubview(productName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //Layout Views
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let buyerImgDim = contentView.frame.size.height-10
        buyerImageView.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              bottom: contentView.bottomAnchor,
                              right: nil,
                              paddingTop: 5,
                              paddingLeft: 15,
                              paddingBottom: 5,
                              width: buyerImgDim,
                              height: buyerImgDim)
        buyerImageView.layer.cornerRadius = buyerImgDim/2

        buyerName.anchor(top: buyerImageView.topAnchor,
                         left: buyerImageView.rightAnchor,
                         bottom: nil,
                         right: contentView.rightAnchor,
                         paddingLeft: 8,
                         paddingRight: 83)

        productName.anchor(top: buyerName.bottomAnchor,
                           left: buyerImageView.rightAnchor,
                           bottom: nil,
                           right: contentView.rightAnchor,
                           paddingTop: 8,
                           paddingLeft: 8,
                           paddingRight: 83)
    }

}
