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
    
    private var filteredUsers = [User]() {
        didSet { self.tableView.reloadData() }
    }
    
    private var inSearchMode: Bool {
        return self.searchController.isActive && !self.searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.fetchUsers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isHidden = false
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
        self.configureSearchController()
    }
    
    
    private func registerCell() {
        self.tableView.register(UserCell.self, forCellReuseIdentifier: reuseID)
        self.tableView.rowHeight = 60
        self.tableView.separatorStyle = .none
    }
    
    
    private func configureSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search for a user"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = false
    }
}


extension ExplorerController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inSearchMode ? self.filteredUsers.count : self.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! UserCell
        
        cell.user = self.inSearchMode ? self.filteredUsers[indexPath.row] : self.users[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.inSearchMode ? self.filteredUsers[indexPath.row] : self.users[indexPath.row]
        let profileController = ProfileController(user: user)
        self.navigationController?.pushViewController(profileController, animated: true)
    }
}


extension ExplorerController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        self.filteredUsers = self.users.filter { $0.username.contains(searchText) || $0.fullname.contains(searchText) }
    }
}
