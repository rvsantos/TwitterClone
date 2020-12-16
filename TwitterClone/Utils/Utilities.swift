//
//  Utilities.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 14/12/20.
//

import UIKit

class Utilities {
    
    static func inputContainerView(withImage image: UIImage, textfield: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8,
                  paddingBottom: 8, width: 24, height: 24)
        
        view.addSubview(textfield)
        textfield.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                         paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    
    static func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
    
    static func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let bt = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        bt.setAttributedTitle(attributedTitle, for: .normal)
        
        return bt
    }
    
    
    static func actionButton(title: String) -> UIButton {
        let bt = UIButton(type: .system)
        bt.backgroundColor = .white
        bt.setTitle(title, for: .normal)
        bt.setTitleColor(.twitterBlue, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.layer.cornerRadius = 5
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return bt
    }
}
