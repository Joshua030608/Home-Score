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
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    
    var images: [UIImage] = []
    var imageIndex: Int? {
        didSet {
            if let imageIndex2 = imageIndex {
                houseImageView.image = images[imageIndex2]
            } else {
                houseImageView.image = nil
            }
            
        }
    }
    
    
    
    @objc func imageViewPressed() {
        print(#function)
//        if let imageIndex = imageIndex {
//            self.imageIndex! += 1
//        } OLD IF STATEMENT || WHY IS IT AN IF LEFT
        
        if imageIndex != nil {
            if imageIndex == images.count - 1 {
                imageIndex = 0
            } else {
                imageIndex! += 1
            }
        }
        
        // bug is pressing imageView too many times causes fatal error index out of range because no more images.
    }
    
    func setLabelText(score: Double?, title: String) {
        var scoreString = "N/A"
        
        if let homeScore = score {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.roundingMode = .halfUp
            formatter.maximumFractionDigits = 1
            if let formattedString = formatter.string(from: NSNumber(value: homeScore)) {
                scoreString = formattedString
            }
        }
        
        let attributedText = NSMutableAttributedString(string: "\(title) Score: \(scoreString)" + "\n", attributes: [.font : UIFont.systemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "$1,000,000", attributes: [.font: UIFont.systemFont(ofSize: 10)]))
        
        label.attributedText = attributedText
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewPressed))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        houseImageView.isUserInteractionEnabled = true
        houseImageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension HouseCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollHandler?(collectionView.tag, collectionView.contentOffset.x)
    }
}



