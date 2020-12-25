//
//  FeedController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet { self.configureProfileImageViewBarItem() }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        self.navigationItem.titleView = imageView
    }
    
    
    private func configureProfileImageViewBarItem() {
        guard let user = self.user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.clipsToBounds = true
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
