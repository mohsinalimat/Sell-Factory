//
//  SFImageButton.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import Foundation
import UIKit

class SFImageButton: UIButton {
    
    init(dim: CGFloat, imageName: String, color: UIColor) {
        super.init(frame: .zero)
        
        setDimensions(height: dim, width: dim)
        layer.cornerRadius = CONST.CORNER_RADII
        setImage(UIImage(systemName: imageName), for: .normal)
        tintColor = color
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
