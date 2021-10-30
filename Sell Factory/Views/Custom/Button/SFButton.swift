//
//  SFButton.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class SFButton: UIButton {
    
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        setTitle(placeHolder, for: .normal)
        setHeight(height: CONST.BUTTON_HEIGHT)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont(name: Font.menlo, size: 16)
        layer.cornerRadius = CONST.CORNER_RADII
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        backgroundColor = COLORS.customLavender
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
