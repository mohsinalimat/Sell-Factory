//
//  CategoryListCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit

class CategoryListCell: UITableViewCell {

    static let identifier = "CategoryListCell"
    
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: Font.menlo, size: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(categoryNameLabel)
        
        categoryNameLabel.anchor(top: topAnchor,
                                 left: leftAnchor,
                                 bottom: bottomAnchor,
                                 right: rightAnchor,
                                 paddingTop: 5,
                                 paddingLeft: 15,
                                 paddingBottom: 5,
                                 paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
