//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: - Properties
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
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
        self.view.backgroundColor = .twitterBlue
        
//        self.logUserOut()
        self.authenticateUserAndConfigureUI()
    }
    
    
    // MARK: - Selectors
    @objc private func actionButtonTapped() {
        guard let user = self.user else { return }
        let nav = UINavigationController(rootViewController: UploadTweetController(user: user))
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - API
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            self.configureUI()
            self.fetchUser()
        }
    }
    
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        UserService.shared.fetchUser(uid: uid) { [weak self] (user) in
            guard let self = self else { return }
            self.user = user
        }
    }
    
    
    private func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        self.configureViewControllers()
        
        self.view.addSubview(self.actionButton)
        self.actionButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor,
                                 paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        self.actionButton.layer.cornerRadius = 56/2
    }
    
    
    private func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navFeed = self.templateNavigationController(viewController: feed, image: #imageLiteral(resourceName: "home_unselected"))
        let explorer = self.templateNavigationController(viewController: ExplorerController(), image: #imageLiteral(resourceName: "search_unselected"))
        let notifications = self.templateNavigationController(viewController: NotificationsController(), image: #imageLiteral(resourceName: "like_unselected"))
        let conversations = self.templateNavigationController(viewController: ConversationsController(), image: #imageLiteral(resourceName: "mail"))
        
        self.viewControllers = [navFeed, explorer, notifications, conversations]
    }
    
    
    private func templateNavigationController(viewController: UIViewController, image: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .white
        return nav
    }
}
