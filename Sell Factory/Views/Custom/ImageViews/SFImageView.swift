//
//  SFImageView.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class SFImageView: UIImageView {
    
    
    init(bgColor: UIColor, contentmode: UIView.ContentMode, clipsTobounds: Bool, isInteractable: Bool, dim: CGFloat) {
        super.init(frame: .zero)
        
        backgroundColor = bgColor
        clipsToBounds = clipsTobounds
        isUserInteractionEnabled = isInteractable
        contentMode = contentmode
        setDimensions(height: dim, width: dim)
        layer.cornerRadius = dim/2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
