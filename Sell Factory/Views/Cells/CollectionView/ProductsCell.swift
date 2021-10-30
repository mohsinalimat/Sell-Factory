//
//  ProductsCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit
import Firebase
import SDWebImage

class ProductsCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ProductsCell"
    
    var product: Product? {
        didSet {
            guard let productName = product?.productName,
                  let description = product?.productDescription,
                  let price = product?.productPrice,
                  let category = product?.productCategory,
                  let user = product?.user,
                  let coverImage = product?.coverImageURL else { return }
            
            productNameLabel.text = productName
            productDescriptionLabel.text = description
            priceLabel.text = price
            categoryLabel.text = category
            
            guard let sellerURL = user.profileImageURL else { return }
            let profileImageURL = URL(string: sellerURL)
            let coverURL = URL(string: coverImage)
            
            DispatchQueue.main.async {
                self.productImageView.sd_setImage(with: coverURL, completed: nil)
                self.sellerProfileImageView.sd_setImage(with: profileImageURL, completed: nil)
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
        label.font = UIFont(name: Font.menloBold, size: 18)
        label.numberOfLines = 4
        label.textAlignment = .center
        label.text = "Mini Photo Album"
        return label
    }()
    
    let productDescriptionLabel = SFLabel(texxt: "This is just a placeholder description to check if the alignments are working properly.",
                                          fontName: Font.menlo,
                                          fontSize: 12,
                                          noOfLines: 2,
                                          texxtColor: .secondaryLabel,
                                          texxtAlignment: .center)
    
    let saveButton: SFImageButton = {
        let button = SFImageButton(dim: 60, imageName: SFSYMBOLS.SAVED, color: .label)
        button.isHidden = true
        return button
    }()
    
    
    let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: Font.menlo, size: 16)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "Price:"
        return label
    }()
    
    
    let priceLabel = SFLabel(texxt: "$100.0", fontName: Font.menloBold, fontSize: 16, noOfLines: 1, texxtColor: .label, texxtAlignment: .left)
    
    
    let soldByTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Seller "
        label.font = UIFont(name: Font.menlo, size: 12)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()

    let sellerProfileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = COLORS.customLavender
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: Font.menlo, size: 14)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.text = CATEGORY.PET
        return label
    }()
    
    
    let priceStack = SFStackView(stackAxis: .horizontal, stackSpace: 8)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(productImageView)
        addSubview(saveButton)
        addSubview(productNameLabel)
        addSubview(categoryLabel)
        addSubview(priceStack)
        priceStack.addArrangedSubview(priceTitleLabel)
        priceStack.addArrangedSubview(priceLabel)
        addSubview(productDescriptionLabel)
        addSubview(sellerProfileImageView)
        addSubview(soldByTitleLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    //MARK: - Layout Views
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let imageDimension = (contentView.frame.size.height)-120
        productImageView.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor,
                                right: nil,
                                paddingTop: 10,
                                paddingLeft: 10,
                                paddingBottom: 110)
        productImageView.setDimensions(height: imageDimension, width: imageDimension)

    

        saveButton.anchor(top: contentView.topAnchor,
                          left: nil,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 10,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 10)

        productNameLabel.anchor(top: contentView.topAnchor,
                                left: productImageView.rightAnchor,
                                bottom: nil,
                                right: saveButton.leftAnchor,
                                paddingTop: 10,
                                paddingLeft: 10,
                                paddingBottom: 0,
                                paddingRight: 10)

        categoryLabel.anchor(top: productNameLabel.bottomAnchor,
                             left: productImageView.rightAnchor,
                             bottom: nil,
                             right: saveButton.leftAnchor,
                             paddingTop: 8,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 10)
        
        priceStack.anchor(top: categoryLabel.bottomAnchor,
                          left: productImageView.rightAnchor,
                          bottom: nil,
                          right: saveButton.leftAnchor,
                          paddingTop: 15,
                          paddingLeft: 10,
                          paddingBottom: 0,
                          paddingRight: 10)
        priceStack.distribution = .fillProportionally

        productDescriptionLabel.anchor(top: priceStack.bottomAnchor,
                                       left: contentView.leftAnchor,
                                       bottom: nil,
                                       right: contentView.rightAnchor,
                                       paddingTop: 15,
                                       paddingLeft: 10,
                                       paddingBottom: 0,
                                       paddingRight: 15)
        
        sellerProfileImageView.anchor(top: nil,
                                      left: nil,
                                      bottom: contentView.bottomAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 10,
                                      paddingRight: 10)
        sellerProfileImageView.setDimensions(height: 40, width: 40)
        sellerProfileImageView.layer.cornerRadius = 40/2
        
        soldByTitleLabel.centerY(inView: sellerProfileImageView)
        soldByTitleLabel.anchor(right: sellerProfileImageView.leftAnchor,
                                paddingRight: 5)
    }

}
