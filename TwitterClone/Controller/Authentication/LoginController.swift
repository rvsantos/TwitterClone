//
//  LoginController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textfield: self.tfEmail)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textfield: self.tfPassword)
        return view
    }()
    
    private let tfEmail: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let tfPassword: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let btSignIn: UIButton = {
        let bt = Utilities.actionButton(title: "Sign In")
        bt.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return bt
    }()
    
    private let btDontHaveAccount: UIButton = {
        let bt = Utilities.attributedButton("Don't have an account. ", "Sign Up")
        bt.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return bt
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    // MARK: - Selectors
    @objc private func handleSignIn() {
        print("Handle sign in...")
    }
    
    
    @objc private func handleShowSignUp() {
        self.navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    
    // MARK: - Helpers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func configureUI() {
        self.view.backgroundColor = .twitterBlue
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isHidden = true
        
        self.addLogoUI()
        self.addStackViewUI()
        self.addBottomButtonUI()
    }
    
    
    private func addLogoUI() {
        self.view.addSubview(self.logoImageView)
        self.logoImageView.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor)
        self.logoImageView.setDimensions(width: 150, height: 150)
    }
    
    
    private func addStackViewUI() {
        let stack = UIStackView(arrangedSubviews: [self.emailContainerView, self.passwordContainerView, self.btSignIn])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        self.view.addSubview(stack)
        stack.anchor(top: self.logoImageView.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    
    
    private func addBottomButtonUI() {
        self.view.addSubview(self.btDontHaveAccount)
        self.btDontHaveAccount.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, height: 20)
        self.btDontHaveAccount.centerX(inView: self.view)
    }
}
