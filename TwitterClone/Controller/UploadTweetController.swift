//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 21/12/20.
//

import UIKit

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    private let user: User
    
    private lazy var actionButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.backgroundColor = .twitterBlue
        bt.setTitle("Tweet", for: .normal)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.setTitleColor(.white, for: .normal)
        bt.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        bt.layer.cornerRadius = 32/2
        bt.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return bt
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48/2
        return iv
    }()

    private let captionTextView = CustomTextView()
    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    // MARK: - Selectors
    @objc private func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handleUploadTweet() {
        guard let caption = self.captionTextView.text else { return }
        
        TweetService.shared.uploadTweet(caption: caption) { [weak self] (error, ref) in
            guard let self = self else { return }
            
            if let error = error {
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - API
    
    
    // MARK: - Private
    private func configureUI() {
        self.view.backgroundColor = .white
        self.configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [self.profileImageView, self.captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .leading
        
        self.view.addSubview(stack)
        stack.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        self.profileImageView.sd_setImage(with: self.user.profileImageUrl, completed: nil)
    }
    
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.actionButton)
    }
}
