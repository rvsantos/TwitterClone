//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by Rafael V. dos Santos on 29/12/20.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.font = .systemFont(ofSize: 14)
        lb.text = "Test filter"
        return lb
    }()
    
    override var isSelected: Bool {
        didSet {
            self.titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
            self.titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    private func configureUI() {
        self.backgroundColor = .white
        
        self.addSubview(self.titleLabel)
        self.titleLabel.center(inView: self)
    }
}
