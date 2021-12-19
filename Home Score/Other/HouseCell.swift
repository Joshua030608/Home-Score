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
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var controller: UIViewController = UIViewController()
    var didScrollHandler: ((Int, CGFloat) -> Void)?
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    
    var images: [UIImage] = []
    var imageIndex: Int? {
        didSet {
            if let imageIndex = imageIndex {
                if images.count != 0 {
                    houseImageView.image = images[imageIndex]
                }
            } else {
                houseImageView.image = nil
            }
            
        }
    }
    
    
    
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        let goodController = controller as! ReportsOverviewViewController
        goodController.editButtonPressedForHouseAt(sender.tag)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
    }
    
    @objc func imageViewPressed() {
        if let imageIndex = imageIndex {
            self.imageIndex = (imageIndex + 1) % images.count
        }
        // bug is pressing imageView too many times causes fatal error index out of range because no more images.
    }
    
    func setLabelText(score: Double?, price: String, address: String) {
        
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
        
        var formattedPriceString = "N/A"
        if let intPrice = Int(price) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            if let formattedString = formatter.string(from: NSNumber(value: intPrice)) {
                formattedPriceString = formattedString
            }
        }
        
        let attributedText = NSMutableAttributedString(string: "\(address) Score: \(scoreString)" + "\n", attributes: [.font : UIFont.systemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: formattedPriceString, attributes: [.font: UIFont.systemFont(ofSize: 10)]))
        
        label.attributedText = attributedText
    }
    
    func getCorrectBorderColor() -> CGColor {
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            return UIColor.white.cgColor
        case .light, .unspecified:
            return UIColor.black.cgColor
        @unknown default:
            return UIColor.black.cgColor
        }
    }
    
    func addTopBorder() {
       let topBorder = CALayer()
        let correctBorderColor = getCorrectBorderColor()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width + 100.0, height: 1.0)
        topBorder.backgroundColor = correctBorderColor
       layer.addSublayer(topBorder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewPressed))
        addTopBorder()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        houseImageView.isUserInteractionEnabled = true
        houseImageView.addGestureRecognizer(tapGestureRecognizer)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//            if traitCollection.userInterfaceStyle == .dark {
//                //Dark
//            } else {
//                //Light
//            }
//        }
//    }
}

extension HouseCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollHandler?(collectionView.tag, collectionView.contentOffset.x)
    }
}



