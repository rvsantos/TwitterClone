//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    let actionButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.tintColor = .white
        bt.backgroundColor = UIColor.twitterBlue
        bt.setImage(#imageLiteral(resourceName: "new_tweet"), for: .normal)
        bt.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    // MARK: - Selectors
    @objc private func actionButtonTapped() {
        print("Action button tapped...")
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        self.configureViewControllers()
        
        self.view.addSubview(self.actionButton)
        self.actionButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        self.actionButton.layer.cornerRadius = 56/2
    }
    
    
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