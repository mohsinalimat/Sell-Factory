//
//  SFTextField.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class SFTextField: UITextField {
    
    
    
    init(placeHolder: String, autoCapital: UITextAutocapitalizationType, autoCorrect: UITextAutocorrectionType, isSecure: Bool, height: CGFloat) {
        super.init(frame: .zero)
        
        backgroundColor = .secondarySystemBackground
        setHeight(height: height)
        layer.cornerRadius = CONST.CORNER_RADII
        placeholder = placeHolder
        let spacer = UIView()
        spacer.setDimensions(height: CONST.TF_HEIGHT, width: 12)
        leftView = spacer
        leftViewMode = .always
        textColor = .label
        font = UIFont(name: Font.menlo, size: 16)
        autocapitalizationType = autoCapital
        autocorrectionType = autoCorrect
        isSecureTextEntry = isSecure
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
