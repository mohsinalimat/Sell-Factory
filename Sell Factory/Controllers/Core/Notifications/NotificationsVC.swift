//
//  NotificationsVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/28/21.
//

import UIKit

class NotificationsVC: UIViewController {
    
    //MARK: - Properties
    
    var notifications = [Notifications]()
    
    private let backButton: SFImageButton = {
        let button = SFImageButton(dim: 45, imageName: SFSYMBOLS.BACK, color: .label)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let pageTitleLabel = SFLabel(texxt: NOTIFICATION_TEXTS.PAGE_TITLE,
                                         fontName: Font.menloBold,
                                         fontSize: 16, noOfLines: 1,
                                         texxtColor: .label,
                                         texxtAlignment: .center)
    
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        tv.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsCell.identifier)
        return tv
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        fetchNotifications()
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    /// Configures Basic UI of the View Controller
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
    
    
    
    /// Refreshes Products
    @objc private func handleRefresh() {
        notifications.removeAll(keepingCapacity: false)
        fetchNotifications()
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//MARK: - Extension


//ARK: - Configure View Extension
extension NotificationsVC {
    
    private func configureViews() {
        //add sub views
        view.addSubview(backButton)
        view.addSubview(pageTitleLabel)
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
        
        tableView.anchor(top: pageTitleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 15,
                         paddingLeft: 5,
                         paddingBottom: 5,
                         paddingRight: 15)
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
}


//MARK: - Extension

//MARK: - Table View Delegate and Data Source
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsCell.identifier, for: indexPath) as! NotificationsCell
        cell.selectionStyle = .none
        cell.notification = notifications[indexPath.row]
        return cell
    }
    
}



//MARK: - API
extension NotificationsVC {
    

    /// Fetches Notification from database
    private func fetchNotifications() {
        let uid = DatabaseManager.getCurrentUid()
        DatabaseManager.shared.fetchNotifications(for: uid, completion: { notifications in
            self.notifications.append(notifications)
            self.notifications.sort { not1, not2 in
                return not1.creationDate > not2.creationDate
            }
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    
}
