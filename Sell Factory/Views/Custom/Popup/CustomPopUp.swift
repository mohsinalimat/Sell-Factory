//
//  CustomPopUp.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/27/21.
//

import Foundation
import UIKit

class CustomPopUp: UIView {
    //MARK: - Properties
    fileprivate let titleLabel: NewCustomLabel = {
        let label = NewCustomLabel(placeholder: "Title",
                                   fontName: Font.menloBold, fontSize: 20,
                                   noOfLines: 1, txtColor: UIColor.black,
                                   bgColor: UIColor.clear, cornerradius: 10,
                                   bordercolor: UIColor.clear, borderwidth: 0, txtAlignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let subtitleLabel: NewCustomLabel = {
        let label = NewCustomLabel(placeholder: "Subtitle",
                                   fontName: Font.menlo, fontSize: 16,
                                   noOfLines: 5, txtColor: UIColor.black,
                                   bgColor: UIColor.clear, cornerradius: 10,
                                   bordercolor: UIColor.clear, borderwidth: 0, txtAlignment: .justified)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let wifiImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wifi.slash")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 35
        return v
    }()
    
    
    
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [UIView(),wifiImage,titleLabel,subtitleLabel, UIView()])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    
    
    
    
    
    //MARK: - Init
    init(popupTitle: String, popupSubtitle: String, customImage: UIImage) {
        super.init(frame: .zero)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
         
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        wifiImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        container.addSubview(stack)
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, constant: 0.5).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -15).isActive = true
        
        
        titleLabel.text = popupTitle
        subtitleLabel.text = popupSubtitle
        wifiImage.image = customImage
        
        animateIn()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Selectors
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.transform = .identity
            self.alpha = 1
        }
    }
    
    
    
}
