//
//  ExplorerController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

private let reuseID = "UserCell"

class ExplorerController: UITableViewController {
    
    // MARK: - Properties
    private var users = [User]() {
        didSet { self.tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.fetchUsers()
    }
    
    
    // MARK: - API
    private func fetchUsers() {
        
        UserService.shared.fetchUsers { (users) in
            self.users = users
        }
    }
    
    
    // MARK: - Private
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Explorer"
        
        self.registerCell()
    }
    
    
    private func registerCell() {
        self.tableView.register(UserCell.self, forCellReuseIdentifier: reuseID)
        self.tableView.rowHeight = 60
        self.tableView.separatorStyle = .none
    }
}


extension ExplorerController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! UserCell
        
        cell.user = self.users[indexPath.row]
        
        return cell
    }
}
