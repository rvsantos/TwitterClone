//
//  CustomTextView.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 23/12/20.
//

import UIKit

class CustomTextView: UITextView {
    
    // MARK:- Properties
    let placeholderLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16)
        lb.textColor = .darkGray
        lb.text = "What's happening?"
        return lb
    }()
    
    
    // MARK:- Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.addObservers()
        self.configureTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Private
    private func configureTextView() {
        backgroundColor = .white
        font = .systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(self.placeholderLabel)
        self.placeholderLabel.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 4)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    
    
    // MARK:- Selectors
    @objc private func handleTextInputChange() {
        self.placeholderLabel.isHidden = !text.isEmpty
    }
}
