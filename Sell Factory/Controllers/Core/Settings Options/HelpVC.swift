//
//  HelpVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import UIKit

class HelpVC: UIViewController {
    
    //MARK: - Properties
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let pageTitleLabel = SFLabel(texxt: "Help",
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    

    
    
    
    
    
    
    //MARK: - Lifecycle
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
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    /// Goes Back to Previous View Controller
    @objc private func handleBackButtonTapped() {
        generateFeedback()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extensions
extension HelpVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
    }
    
    
}
