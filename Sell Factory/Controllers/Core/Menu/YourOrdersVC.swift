//
//  YourOrdersVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit
import Firebase



class YourOrdersVC: UIViewController {


    //MARK: - Properties
    var purchasedProducts = [Product]()
    var receiverOrders = [Notifications]()
    
    var isReceivedOrdersSelected = false
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageTitleLabel = SFLabel(texxt: YOURORDER_TEXTS.PAGE_TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)

    
    //Segment Control
    let items = ["History","Received Orders"]
    lazy var ordersSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.setHeight(height: 35)
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = COLORS.customLavender
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 9
        segmentedControl.layer.masksToBounds = true
        segmentedControl.addTarget(self, action: #selector(ordersSegmentControlTapped(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(SavedProductsCell.self, forCellReuseIdentifier: SavedProductsCell.identifier)
        tv.register(ReceivedOrdersCell.self, forCellReuseIdentifier: ReceivedOrdersCell.identifier)
        tv.separatorColor = .clear
        return tv
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchHistroy()
        fetchReceivedOrders()        
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Configures Basic UI of the View Controller
    private func configureUI() {
        print("DEBUG: Your Orders Page")
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
    
    
    
    
    /// Segment Control To see If International Shipping is Available
    /// - Parameter segmentedControl: segmented control
    @objc func ordersSegmentControlTapped(_ segmentedControl:UISegmentedControl!) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            generateFeedback()
            print("DEBUG: Place Order Selected")
            isReceivedOrdersSelected = false
            tableView.reloadData()
            break
        case 1:
            generateFeedback()
            print("DEBUG: Received Orders Selected")
            isReceivedOrdersSelected = true
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extension


//ARK: - Configure View Extension
extension YourOrdersVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
        view.addSubview(ordersSegmentControl)
        view.addSubview(tableView)
        
        
        //layout views
        backButton.centerY(inView: pageTitleLabel)
        backButton.anchor(left: view.leftAnchor,paddingLeft: 15)
        
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingLeft: 68,
                              paddingRight: 68)
        
        ordersSegmentControl.anchor(top: pageTitleLabel.bottomAnchor,
                                    left: view.leftAnchor,
                                    bottom: nil,
                                    right: view.rightAnchor,
                                    paddingTop: 15,
                                    paddingLeft: 25,
                                    paddingRight: 25)
        
        
        tableView.anchor(top: ordersSegmentControl.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 5,
                         paddingBottom: 0,
                         paddingRight: 5)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    
}


//MARK: - Extension

//MARK: - Tableview Delegate, Datasource
extension YourOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isReceivedOrdersSelected == false {
            return purchasedProducts.count
        } else {
            return receiverOrders.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isReceivedOrdersSelected == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: SavedProductsCell.identifier, for: indexPath) as! SavedProductsCell
            cell.selectionStyle = .none
            cell.product = purchasedProducts[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedOrdersCell.identifier, for: indexPath) as! ReceivedOrdersCell
            cell.selectionStyle = .none
            cell.receivedOrder = receiverOrders[indexPath.row]
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        generateFeedback()
        tableView.deselectRow(at: indexPath, animated: true)
        
        var received: Notifications?
        var purchasedOrder: Product?
        if isReceivedOrdersSelected != false {
            received = receiverOrders[indexPath.row]
            guard let uid = received?.buyerID else { return }
            guard let productID = received?.productID else { return }
            openChatWith(uid: uid, productID: productID)
        } else {
            purchasedOrder = purchasedProducts[indexPath.row]
            guard let uid = purchasedOrder?.ownerID else { return }
            guard let productID = purchasedOrder?.productID else { return }
            openChatWith(uid: uid, productID: productID)
        }
        
        
    }
    
    
    
    
    
}




//MARK: - API
extension YourOrdersVC {

    
    
    /// Fetches Purchased History Orders for User
    private func fetchHistroy() {
        let uid = DatabaseManager.getCurrentUid()
        PURCHASED_REF.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ snapshot in
                let productID = snapshot.key
                DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                    self.purchasedProducts.append(product)
                    self.tableView.reloadData()
                })
            })
            self.tableView.reloadData()
        })
    }
    
    
    
    
    
    /// Fetches Received Orders for User
    private func fetchReceivedOrders() {
        let uid = DatabaseManager.getCurrentUid()
        DatabaseManager.shared.fetchReceivedOrdersForUser(for: uid, completion: { notification in
            self.receiverOrders.append(notification)
            self.tableView.reloadData()
        })
    }
    
    
    
    
    /// Opens chat with specified uid
    /// - Parameter uid: String
    private func openChatWith(uid: String, productID: String) {
        print("DEBUG: Opening Chat with...uid: \(uid)")
        //fetch this user with uid
        DatabaseManager.shared.fetchUser(with: uid, completion: { user in
            
            DatabaseManager.shared.fetchAllProducts(with: productID, completion: { product in
                let vc = OrderDetailsVC(user: user, product: product)
                self.navigationController?.pushViewController(vc, animated: true)
            })
        })
    }

    
}


