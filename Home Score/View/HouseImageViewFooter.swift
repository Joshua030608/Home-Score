//
//  HouseImageViewFooter.swift
//  Home Score
//
//  Created by Joshua Ford on 10/2/21.
//

import UIKit

class HouseImageViewFooter: UICollectionReusableView {
    static let id = "HouseImageViewFooter"
    
    var button: UIButton {

        let config = UIImage.SymbolConfiguration(pointSize: 35.0)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        image!.withRenderingMode(.alwaysOriginal)
        
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        
        return button
    }
    
    var label: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "Add Image"
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(button)
        addSubview(label)
        
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
        button.heightAnchor.constraint(equalToConstant: frame.height/2).isActive = true
        
        label.topAnchor.constraint(equalTo: button.topAnchor, constant: 8).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
        label.widthAnchor.constraint(equalToConstant: frame.height/2).isActive = true
    }
    
}
