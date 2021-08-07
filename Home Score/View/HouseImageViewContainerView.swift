//
//  HouseImageViewContainerView.swift
//  Home Score
//
//  Created by Joshua Ford on 7/20/21.
//

import UIKit

class HouseImageViewContainerView: UIView {
    
    private var primaryImageViewLeadingConstraint: NSLayoutConstraint!
    private var primaryImageViewTrailingConstraint: NSLayoutConstraint!
    private let primaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var secondaryImageViewLeadingConstraint: NSLayoutConstraint!
    private var secondaryImageViewTrailingConstraint: NSLayoutConstraint!
    private let secondaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    fileprivate var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    fileprivate var numberOfSwipes = 0
    
    var images: [UIImage] = [] {
        didSet {
            primaryImageView.image = images.first
            if images.count > 1 {
                secondaryImageView.image = images[1]
            }
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
        addGestureRecognizer(swipeGestureRecognizer)
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3.0
    }
    
    fileprivate func setUpView() {
        addSubview(primaryImageView)
        primaryImageViewLeadingConstraint = primaryImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        primaryImageViewLeadingConstraint.isActive = true
        primaryImageViewTrailingConstraint = primaryImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        primaryImageViewTrailingConstraint.isActive = true
        primaryImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        primaryImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        primaryImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(secondaryImageView)
        secondaryImageViewLeadingConstraint = primaryImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        secondaryImageViewLeadingConstraint.isActive = true
        secondaryImageViewTrailingConstraint = primaryImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        secondaryImageViewTrailingConstraint.isActive = true
        secondaryImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        secondaryImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        secondaryImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc fileprivate func houseImageViewSwiped() {
        print("Has Swiped. Number of Images: \(images.count)")
        if images.count > 1 {
            self.numberOfSwipes += 1
    
             
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.primaryImageViewLeadingConstraint.constant = -self.frame.size.width
                self.primaryImageViewTrailingConstraint.constant = self.frame.size.width
                self.secondaryImageViewLeadingConstraint.constant = 0
                self.secondaryImageViewTrailingConstraint.constant = self.frame.size.width
                self.layoutIfNeeded()
            }) { (_) in
                // "Completion Block"
                self.primaryImageView.image = self.secondaryImageView.image
                self.secondaryImageView.image = self.images[self.numberOfSwipes + 1]
//                self.setUpView()
                self.layoutIfNeeded()
                print("animation done")
            }
        }
    }
}
