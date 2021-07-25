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
    
    fileprivate var numberOfSwipes: Int
    
    var images: [UIImage] = [] {
        didSet {
            firstImageView.image = images.first
            if images.count > 1 {
                secondImageView.image = images[1]
            }
        }
    }
    init() {
        self.numberOfSwipes = 0
        super.init(frame: .zero)
        setUpView()
        self.numberOfSwipes = 0
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(houseImageViewSwiped))
    }
    
    required init?(coder: NSCoder) {
        self.numberOfSwipes = 0
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
        print("Has Swiped. Number of Images: \(images.count)")
        if images.count > 1 {
            self.numberOfSwipes += 1
            
            self.firstImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = false
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.firstImageView.trailingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                self.secondImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                self.layoutIfNeeded()
            }) { (_) in
                // "Completion Block"
                self.firstImageView.image = self.secondImageView.image
                self.secondImageView.image = self.images[self.numberOfSwipes]
                self.setUpView()
                self.layoutIfNeeded()
                print("animation done")
            }
        }
    }
}
