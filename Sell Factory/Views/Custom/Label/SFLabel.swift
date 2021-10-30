//
//  SFLabel.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import Foundation
import UIKit

class SFLabel: UILabel {
    
    
    init(texxt: String, fontName: String, fontSize: CGFloat, noOfLines: Int, texxtColor: UIColor, texxtAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        text = texxt
        font = UIFont(name: fontName, size: fontSize)
        numberOfLines = noOfLines
        textColor = texxtColor
        textAlignment = texxtAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
