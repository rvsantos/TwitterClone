//
//  NotificationsController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class NotificationsController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Notifications"
    }
}
