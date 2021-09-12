//
//  HouseImageViewCell.swift
//  Home Score
//
//  Created by Joshua Ford on 9/1/21.
//

import UIKit

class HouseImageViewCell: UICollectionViewCell {
    var didPressDeleteButtonHandler: ((Int) -> Void)?
    
    static let id = NSStringFromClass(HouseImageViewCell.self)
    
     let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 35.0)
        let image = UIImage.init(systemName: "xmark.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    fileprivate func setUpView() {
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(deleteButton)
        deleteButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteButtonPressed))
        deleteButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func deleteButtonPressed() {
        didPressDeleteButtonHandler?(tag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
