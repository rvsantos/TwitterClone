//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .twitterBlue
        self.navigationController?.navigationBar.isHidden = true
    }
}
