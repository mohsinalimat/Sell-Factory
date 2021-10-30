//
//  TitleLabel.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class TitleLabel: UILabel {
    
    
    
    init(name: String) {
        super.init(frame: .zero)
        
        text = name
        textColor = .label
        textAlignment = .center
        font = UIFont(name: Font.menloBold, size: 30)
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
