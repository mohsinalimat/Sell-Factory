//
//  ProductImageCell.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import UIKit
import Firebase
import SDWebImage

class ProductImageCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ProductImageCell"
    
    private var viewModel: ProductImagesCellViewModel?

    let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.layer.cornerRadius = 25
        image.image = #imageLiteral(resourceName: "5")
        return image
    }()
    
    
    
    
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(productImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: - Layout views
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let height = contentView.frame.size.width
        productImage.setDimensions(height: height, width: height)
        productImage.anchor(top: topAnchor,
                            left: leftAnchor,
                            bottom: bottomAnchor,
                            right: rightAnchor)
    }
    
    
    
    
    
    /// Configures the cell with View Model
    /// - Parameter model: URL
    func configure(with model: ProductImagesCellViewModel) {
        self.viewModel = model
        for text in model.url {
            let imgURL = URL(string: text)
            DispatchQueue.main.async {
                self.productImage.sd_setImage(with: imgURL, completed: nil)
            }
        }
    }
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
}
