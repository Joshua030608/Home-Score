//
//  HomeDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
 
    var imageIndices: [Int?]
    
    var didScrollHandler: ((Int, CGFloat) -> Void)?
    
    override init() {
        
        var indices: [Int?] = []
        for home in HomeStore.shared.homes {
            let index = (home.photos.isEmpty) ? nil : 0
            indices.append(index)
        }
        self.imageIndices = indices
        
        super.init()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(HomeStore.shared.homes.count)
        return HomeStore.shared.homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseCell.id, for: indexPath) as! HouseCell
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewPressed))
//        cell.imageView!.isUserInteractionEnabled = true
//        cell.imageView!.addGestureRecognizer(tapGestureRecognizer)
//        cell.imageView!.tag = indexPath.row
        let home = HomeStore.shared.homes[indexPath.row]
        var scoreString = "N/A"
        if let homeScore = home.score {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.roundingMode = .halfUp
            formatter.maximumFractionDigits = 1
            if let formattedString = formatter.string(from: NSNumber(value: homeScore)) {
                scoreString = formattedString
            }
        }
        
//        // 4.8500000001 -> 4.8
//        let multipliedScoreDouble = 4.8 * 10.0 // 48.500001
//        let multipliedScoreInt = Int(multipliedScoreDouble) // 48
        
        let attributedText = NSMutableAttributedString(string: "\(home.title) Score: \(scoreString)" + "\n", attributes: [.font : UIFont.systemFont(ofSize: 18)])
        // 4.8000000000001 -> 4.8
        
        
        attributedText.append(NSAttributedString(string: "$1,000,000", attributes: [.font: UIFont.systemFont(ofSize: 10)]))
        cell.label.attributedText = attributedText
        
        
        cell.collectionView.dataSource = self
//        if let imageIndex = imageIndices[indexPath.row] {
//            cell.imageView!.image = home.photos[imageIndex]
//        } else {
//            cell.imageView!.image = nil
//        }
        cell.imageView?.layer.borderWidth = 6.0
        cell.imageView?.layer.borderColor = UIColor.red.cgColor
         
        cell.collectionView.tag = indexPath.row
        cell.didScrollHandler = { [weak self] (index, offset) in
            self?.didScrollHandler?(index, offset)
        }
        
        // ARC - Automatic Reference Counting
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    @objc fileprivate func imageViewPressed(gestureRecognizer: UITapGestureRecognizer) {
        let index = gestureRecognizer.view!.tag
        let imageView = gestureRecognizer.view as! UIImageView
        if let imageIndex = imageIndices[index] {
            let homePhotos = HomeStore.shared.homes[index].photos
            let imageIndex = (imageIndex + 1) % homePhotos.count
            imageIndices[index] = imageIndex
            imageView.image = homePhotos[imageIndex]
        }
    }
}

extension HomeDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryStore.shared.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompareCell.id, for: indexPath) as! CompareCell
        let home = HomeStore.shared.homes[collectionView.tag]
        let CategoryDataSource = CategoryScoresHouseDataSource(scoresDictionary: home.categoryScores)
        let category = CategoryDataSource.category(forIndexPath: indexPath)
        let score = CategoryDataSource.score(forCategory: category)
        cell.titleLabel.text = category.name
        
        // TODO: This
        cell.scoreLabel.text = (score == Category.NAValue) ? "N/A" : "\(score)"
        return cell
    }
}

