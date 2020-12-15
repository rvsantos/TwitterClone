//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let btPlusPhoto: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return bt
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textfield: self.tfEmail)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: self.tfFullname)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: self.tfUsername)
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
    
    private let tfFullname: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Fullname")
        return tf
    }()
    
    private let tfUsername: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let tfPassword: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let btSignUp: UIButton = {
        let bt = UIButton(type: .system)
        bt.backgroundColor = .white
        bt.setTitle("Sign Up", for: .normal)
        bt.setTitleColor(.twitterBlue, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.layer.cornerRadius = 5
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return bt
    }()
    
    private let btAlreadyHaveAccount: UIButton = {
        let bt = Utilities.attributedButton("Already have an account. ", "Sign In")
        bt.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return bt
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    // MARK: - Selectors
    @objc private func handleSignUp() {
        print("Handle sign up...")
    }
    
    
    @objc private func handleShowSignIn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func handleSelectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - Helpers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func configureUI() {
        self.view.backgroundColor = .twitterBlue
        self.navigationController?.navigationBar.isHidden = true
        
        self.addPlusPhotoButtonUI()
        self.addStackViewUI()
        self.addBottomButtonUI()
    }
    
    
    private func addPlusPhotoButtonUI() {
        self.view.addSubview(self.btPlusPhoto)
        self.btPlusPhoto.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 16, width: 140, height: 140)
        self.btPlusPhoto.centerX(inView: self.view)
    }
    
    
    private func addStackViewUI() {
        let stack = UIStackView(arrangedSubviews: [self.emailContainerView, self.fullnameContainerView,
                                                   self.usernameContainerView, self.passwordContainerView,
                                                   self.btSignUp])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        self.view.addSubview(stack)
        stack.anchor(top: self.btPlusPhoto.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 32, paddingRight: 32)
    }
    
    
    private func addBottomButtonUI() {
        self.view.addSubview(self.btAlreadyHaveAccount)
        self.btAlreadyHaveAccount.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, height: 20)
        self.btAlreadyHaveAccount.centerX(inView: self.view)
    }
    
    
    private func configurePhotoBottomUI(image: UIImage) {
        self.btPlusPhoto.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btPlusPhoto.layer.cornerRadius = self.btPlusPhoto.frame.width/2
        self.btPlusPhoto.clipsToBounds = true
        self.btPlusPhoto.layer.borderColor = UIColor.black.cgColor
        self.btPlusPhoto.layer.borderWidth = 2
    }
}


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        self.configurePhotoBottomUI(image: image)
        
        self.dismiss(animated: true, completion: nil)
    }
}