//
//  HouseImageViewFooter.swift
//  Home Score
//
//  Created by Joshua Ford on 10/2/21.
//

import UIKit

class HouseImageViewFooter: UICollectionReusableView {
    
    static let id = "HouseImageViewFooter"
    
    var buttonPressedHandler: (() -> Void)?
    
    var button: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 35.0)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        image!.withRenderingMode(.alwaysOriginal)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "Add Image"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        button.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func addImageButtonPressed() {
        buttonPressedHandler?()
    }
    
    func setUpLayout() {
        addSubview(button)
        addSubview(label)
        
        print(frame)
    
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
