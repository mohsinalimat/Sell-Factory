//
//  SFAttributedButton.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class SFAttributedButton: UIButton {
    
    
    
    init(titleOne: String, titleTwo: String) {
        super.init(frame: .zero)
        
        let attributedTitle = NSMutableAttributedString(string: "\(titleOne)  ",
                                                        attributes: [NSAttributedString.Key.font: UIFont(name: Font.menlo, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        attributedTitle.append(NSAttributedString(string: "\(titleTwo)",
                                                  attributes: [NSAttributedString.Key.font: UIFont(name: Font.menloBold, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.label]))
        setAttributedTitle(attributedTitle, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
