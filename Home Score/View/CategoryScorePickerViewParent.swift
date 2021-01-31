//
//  CategoryScorePickerViewParent.swift
//  Home Score
//
//  Created by Joshua Ford on 1/26/21.
//
import UIKit

class CategoryScorePickerViewParent: UIView {
    
    //var xButtonPressedHandler: (() -> Void)?
    
    fileprivate let categoryScorePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .systemBackground
        return picker
    }()
    
    fileprivate let xButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        return button
    }()
    
    fileprivate func setUpLayout() {
        categoryScorePicker.widthAnchor.constraint(equalToConstant: 10).isActive = true
        categoryScorePicker.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryScorePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        categoryScorePicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        xButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        xButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        xButton.leadingAnchor.constraint(equalTo: categoryScorePicker.trailingAnchor, constant: 8).isActive = true
        xButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryScorePicker)
        addSubview(xButton)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
