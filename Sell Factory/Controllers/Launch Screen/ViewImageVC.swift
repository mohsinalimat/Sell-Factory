//
//  ViewImageVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import UIKit

class ViewImageVC: UIViewController {
    
    //MARK: - Properties
    var vcPicture: UIImage?
    var vcTitle: String?
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: SFSYMBOLS.BACK), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapBackButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.menloBold, size: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    init(vcPicture: UIImage, vcTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.vcTitle = vcTitle
        self.vcPicture = vcPicture
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    
    
    
    
    //MARK: - Helpers
    private func configureUI() {
        setupTapGesture()
        setupVC(bgColor: .systemBackground)
        configureViews()
    }
    
    
    
    
    private func configureViews() {
        //add sub view
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(photoImageView)
        
        //layout view
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: nil,
                          right: view.rightAnchor,
                          paddingTop: 15,
                          paddingLeft: 38,
                          paddingRight: 38)
        
        backButton.centerY(inView: titleLabel)
        backButton.anchor(left: view.leftAnchor,
                          paddingLeft: 15)
        
        photoImageView.anchor(top: titleLabel.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor)
        
        titleLabel.text = vcTitle
        photoImageView.image = vcPicture
    }
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    /// Goes back to Previous View Controller
    /// - Parameter sender: UIButton
    @objc private func didTapBackButton(sender: UIButton) {
        sender.showAnimation {
            self.generateFeedback()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
}
