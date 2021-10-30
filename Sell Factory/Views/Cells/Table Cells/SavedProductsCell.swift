//
//  SavedProductsCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 7/3/21.
//

import UIKit
import SDWebImage

class SavedProductsCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "SavedProductsCell"
    
    var product: Product? {
        didSet {
            guard let product = self.product else { return }
            guard let name = product.productName,
                  let coverImageURL = product.coverImageURL,
                  let price = product.productPrice,
                  let inStock = product.itemsInStock else { return }
            
            productNameLabel.text = "\(name) - \(price)"
            inStockLabel.text = "\(inStock) InStock"
            let url = URL(string: coverImageURL)
            DispatchQueue.main.async {
                self.coverImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    
    
    private let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderColor = COLORS.customLavender.cgColor
        iv.layer.borderWidth = 1.2
        return iv
    }()
    
    
    private let productNameLabel = SFLabel(texxt: "", fontName: Font.menloBold,
                                           fontSize: 14, noOfLines: 0, texxtColor: .label, texxtAlignment: .left)
    
    private let inStockLabel = SFLabel(texxt: "", fontName: Font.menlo,
                                           fontSize: 12, noOfLines: 0, texxtColor: .secondaryLabel, texxtAlignment: .left)
    
    
    
    
    
    
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(coverImageView)
        addSubview(productNameLabel)
        addSubview(inStockLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    //MARK: - Layout Views
    override func layoutSubviews() {
        super.layoutSubviews()
                
        let imgDim = contentView.frame.size.height-10
        coverImageView.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: nil,
                              paddingTop: 5,
                              paddingLeft: 15,
                              paddingBottom: 5,
                              paddingRight: 0)
        coverImageView.setDimensions(height: imgDim, width: imgDim)
        
        productNameLabel.anchor(top: coverImageView.topAnchor,
                                left: coverImageView.rightAnchor,
                                bottom: nil,
                                right: contentView.rightAnchor,
                                paddingLeft: 8,
                                paddingRight: 15)
        
        inStockLabel.anchor(top: productNameLabel.bottomAnchor,
                            left: coverImageView.rightAnchor,
                            bottom: nil,
                            right: contentView.rightAnchor,
                            paddingTop: 8,
                            paddingLeft: 8,
                            paddingRight: 15)
        
    }
    
    
}
