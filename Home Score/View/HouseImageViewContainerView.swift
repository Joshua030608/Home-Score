//
//  HouseImageViewContainerView.swift
//  Home Score
//
//  Created by Joshua Ford on 7/20/21.
//

import UIKit

class HouseImageViewContainerView: UIView {
    
    fileprivate var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    var images: [UIImage] = []
    
    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    fileprivate func setUpLayout() {
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
   fileprivate func setUpView() {
        setUpLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension HouseImageViewContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.tag = indexPath.row
        return cell
    }
    
    
}

extension HouseImageViewContainerView: UICollectionViewDelegate {
    
}

extension HouseImageViewContainerView: UICollectionViewDelegateFlowLayout {
    
}
