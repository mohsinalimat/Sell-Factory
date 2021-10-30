//
//  ProductsGridViewCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/30/21.
//

import UIKit
import Firebase
import SDWebImage


class ProductsGridViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "ProductsGridViewCell"
    
    var product: Product? {
        didSet {
            guard let name = product?.productName,
                  let price = product?.productPrice,
                  let coverImage = product?.coverImageURL else { return }
            
            productNameLabel.text = name
            priceLabel.text = price
            let url = URL(string: coverImage)
            DispatchQueue.main.async {
                self.productImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    
    
    let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = COLORS.customLavender
        image.layer.cornerRadius = 12
        return image
    }()
    
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: Font.menloBold, size: 14)
        label.numberOfLines = 4
        label.textAlignment = .center
        label.text = "Mini Photo Album"
        return label
    }()
    
    
    let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: Font.menlo, size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "Price:"
        return label
    }()
    
    
    let priceLabel = SFLabel(texxt: "$100.0", fontName: Font.menloBold, fontSize: 16, noOfLines: 1, texxtColor: .label, texxtAlignment: .left)
    
    let priceStack = SFStackView(stackAxis: .horizontal, stackSpace: 8)
    
    
    
    
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(priceStack)
        priceStack.addArrangedSubview(priceTitleLabel)
        priceStack.addArrangedSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productImageView.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                bottom: nil,
                                right: contentView.rightAnchor,
                                paddingTop: 10,
                                paddingLeft: 10,
                                paddingRight: 10)
        let dim = (contentView.frame.size.width-20)
        productImageView.setDimensions(height: dim-10, width: dim)
        
        productNameLabel.centerX(inView: productImageView)
        productNameLabel.anchor(top: productImageView.bottomAnchor,
                                paddingTop: 8)
        
        
        priceStack.anchor(top: productNameLabel.bottomAnchor,
                          left: productImageView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: productImageView.rightAnchor,
                          paddingTop: 8,
                          paddingBottom: 8)
        priceStack.distribution = .fillProportionally
        
    }
    
}
