//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemPurple
        self.configureViewControllers()
    }
    
    
    // MARK: - Helpers
    private func configureViewControllers() {
    
        let feed = self.templateNavigationController(viewController: FeedController(), image: #imageLiteral(resourceName: "home_unselected"))
        let explorer = self.templateNavigationController(viewController: ExplorerController(), image: #imageLiteral(resourceName: "search_unselected"))
        let notifications = self.templateNavigationController(viewController: NotificationsController(), image: #imageLiteral(resourceName: "like_unselected"))
        let conversations = self.templateNavigationController(viewController: ConversationsController(), image: #imageLiteral(resourceName: "mail"))
        
        self.viewControllers = [feed, explorer, notifications, conversations]
    }
    
    
    private func templateNavigationController(viewController: UIViewController, image: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .white
        return nav
    }
}
