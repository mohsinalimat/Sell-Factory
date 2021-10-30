//
//  ProfileSettingsMenuCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit

class ProfileSettingsMenuCell: UITableViewCell {
    
    //MARK: - Properties

    static let identifier = "ProfileSettingsMenuCell"
    
    let leftImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        return iv
    }()

    lazy var leftLabel = SFLabel(texxt: "", fontName: Font.menlo, fontSize: 14, noOfLines: 1, texxtColor: .label, texxtAlignment: .left)

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(leftImageView)
        addSubview(leftLabel)
        
        
        leftImageView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: nil,
                             paddingTop: 5,
                             paddingLeft: 25,
                             paddingBottom: 5,
                             paddingRight: 0)
        
        leftLabel.centerY(inView: leftImageView)
        leftLabel.anchor(left: leftImageView.rightAnchor,
                         paddingLeft: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
