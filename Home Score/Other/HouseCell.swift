//
//  HouseCell.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HouseCell: UITableViewCell {
    static let id = NSStringFromClass(HouseCell.self)
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    var didScrollHandler: ((Int, CGFloat) -> Void)?
}

extension HouseCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollHandler?(collectionView.tag, collectionView.contentOffset.x)
    }
}



