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
        self.collectionView.register(HouseImageViewCell.self, forCellWithReuseIdentifier: HouseImageViewCell.id)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.collectionView.register(HouseImageViewCell.self, forCellWithReuseIdentifier: HouseImageViewCell.id)
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
    
    fileprivate func deleteImageAt(index: Int) {
        images.remove(at: index)
        collectionView.reloadData()
    }
    
}

extension HouseImageViewContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseImageViewCell.id, for: indexPath) as! HouseImageViewCell
        cell.tag = indexPath.row
        cell.imageView.image = images[indexPath.row]
        cell.didPressDeleteButtonHandler = { [weak self] (index) in
            self?.deleteImageAt(index: index)
        }
        return cell
    }
}

extension HouseImageViewContainerView: UICollectionViewDelegate {
    
}

extension HouseImageViewContainerView: UICollectionViewDelegateFlowLayout {
    
}
