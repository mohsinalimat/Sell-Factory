//
//  SFStackView.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class SFStackView: UIStackView {
    init(stackAxis: NSLayoutConstraint.Axis, stackSpace: CGFloat) {
        super.init(frame: .zero)
        
        axis = stackAxis
        spacing = stackSpace
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
