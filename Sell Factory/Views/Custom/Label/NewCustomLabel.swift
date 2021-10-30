//
//  NewCustomLabel.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class NewCustomLabel: UILabel {
    
    
    //MARK: - Init
    init(placeholder: String,
         fontName: String, fontSize: CGFloat,
         noOfLines: Int, txtColor: UIColor,
         bgColor: UIColor, cornerradius: CGFloat,
         bordercolor: UIColor, borderwidth: CGFloat, txtAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        textAlignment = txtAlignment
        text = placeholder
        font = UIFont(name: fontName, size: fontSize)
        numberOfLines = noOfLines
        textColor = txtColor
        backgroundColor = bgColor
        layer.cornerRadius = cornerradius
        layer.borderColor = bordercolor.cgColor
        layer.borderWidth = borderwidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
