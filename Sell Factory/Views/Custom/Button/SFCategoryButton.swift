//
//  SFCategoryButton.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import Foundation
import UIKit

class SFCategoryButton: UIButton {
    
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        setTitle(placeHolder, for: .normal)
        setHeight(height: CONST.BUTTON_HEIGHT)
        titleLabel?.textColor = .label
        setTitleColor(.label, for: .normal)
        titleLabel?.font = UIFont(name: Font.menlo, size: 16)
        layer.cornerRadius = CONST.CORNER_RADII
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        backgroundColor = .clear
        layer.borderColor =  UIColor.secondarySystemBackground.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
