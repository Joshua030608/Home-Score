//
//  HouseImageViewContainerView.swift
//  Home Score
//
//  Created by Joshua Ford on 7/20/21.
//

import UIKit

class HouseImageViewContainerView: UIView {
    
    private let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    var images: [UIImage] = [] {
        didSet {
            firstImageView.image = images.first
        }
    }
    
    init() {
        super.init(frame: .zero)
        setUpView()
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(houseImageViewSwiped))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(houseImageViewSwiped))
    }
    
    fileprivate func setUpView() {
        addSubview(firstImageView)
        firstImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        firstImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        firstImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(secondImageView)
        secondImageView.leadingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        secondImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        secondImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        secondImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc fileprivate func houseImageViewSwiped() {
        // something
    }
}
