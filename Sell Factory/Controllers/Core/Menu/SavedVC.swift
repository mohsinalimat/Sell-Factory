//
//  SavedVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit
import Firebase



class SavedVC: UIViewController {
    
    //MARK: - Properties
    var product = [Product]()
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageTitleLabel = SFLabel(texxt: SAVED_TEXTS.PAGE_TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)

    
    //Table View
    private let savedProductsTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.register(SavedProductsCell.self, forCellReuseIdentifier: SavedProductsCell.identifier)
        return tv
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchSavedProducts()
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Configures Basic UI of the View Controller
    private func configureUI() {
        print("DEBUG: Saved VC")
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
//MARK: - Extension


//ARK: - Configure View Extension
extension SavedVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
        view.addSubview(savedProductsTableView)
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
        //tableview
        savedProductsTableView.anchor(top: pageTitleLabel.bottomAnchor,
                                      left: view.leftAnchor,
                                      bottom: view.bottomAnchor,
                                      right: view.rightAnchor,
                                      paddingTop: 15,
                                      paddingLeft: 5,
                                      paddingBottom: 0,
                                      paddingRight: 5)
        savedProductsTableView.delegate = self
        savedProductsTableView.dataSource = self
        
    }
    
}


//MARK: - TableView Delegates and DataSource
extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedProductsTableView.dequeueReusableCell(withIdentifier: SavedProductsCell.identifier, for: indexPath) as! SavedProductsCell
        cell.selectionStyle = .none
        cell.product = product[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = product[indexPath.row].productID else { return }
            removeFromSavedList(indexPath: indexPath, productID: id)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        generateFeedback()
        savedProductsTableView.deselectRow(at: indexPath, animated: true)
        var products: Product!
        products = product[indexPath.row]
        let vc = ProductDetailsVC(product: products)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


//MARK: - API
extension SavedVC {
    
    
    /// Fetches Saved Products for the current Use From Firebase Saved_ref
    private func fetchSavedProducts() {
        let uid = DatabaseManager.getCurrentUid()
        SAVED_REF.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ snapshot in
                let productID = snapshot.key
                DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                    self.product.append(product)
                    self.savedProductsTableView.reloadData()
                })
            })
        })
    }
    
    
    
    
    /// Deletes From Saved List
    /// - Parameter indexPath: Position
    private func removeFromSavedList(indexPath: IndexPath, productID: String) {
        DatabaseManager.shared.deleteProductFromSavedRef(productID: productID, completion: { deleted in
            if deleted {
                self.product.remove(at: indexPath.row)
                self.savedProductsTableView.deleteRows(at: [indexPath], with: .fade)
                ToastView.shared.short(self.view, txt_msg: "Removed")
            } else {
                ToastView.shared.short(self.view, txt_msg: "Failed To Delete")
            }
        })
    }
    
    
    
    
}
