//
//  HouseImageViewContainerView.swift
//  Home Score
//
//  Created by Joshua Ford on 7/20/21.
//

import UIKit

class HouseImageViewContainerView: UIView {
    
    var imageDeletedHandler: ((Int) -> Void)?
    
    var addImageHandler: (() -> Void)?
    
    var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        return cv
    }()
    
    var images: [UIImage] = []
    
    init() {
        super.init(frame: .zero)
        self.collectionView.register(HouseImageViewCell.self, forCellWithReuseIdentifier: HouseImageViewCell.id)
        self.collectionView.register(HouseImageViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HouseImageViewFooter.id)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.collectionView.register(HouseImageViewCell.self, forCellWithReuseIdentifier: HouseImageViewCell.id)
        self.collectionView.register(HouseImageViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HouseImageViewFooter.id)
        setUpView()
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
        imageDeletedHandler?(index)
        collectionView.reloadData()
    }
    
    func reloadImages() {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HouseImageViewFooter.id, for: indexPath) as! HouseImageViewFooter
            footer.buttonPressedHandler = addImageHandler
            return footer
        }
        return UICollectionReusableView()
    }
}

extension HouseImageViewContainerView: UICollectionViewDelegate {
    
}

extension HouseImageViewContainerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
