//
//  HomeDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
    var didScrollHandler: ((Int, CGFloat) -> Void)?
    
    override init() {
        super.init()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(HomeStore.shared.homes.count)
        return HomeStore.shared.homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseCell.id, for: indexPath) as! HouseCell
        let home = HomeStore.shared.homes[indexPath.row]
//        cell.titleLabel.text = home.title
//        cell.homeScoreLabel.text = String(home.score)
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
        cell.houseImageView.image = home.photos.first
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.didScrollHandler = { [weak self] (index, offset) in
            self?.didScrollHandler?(index, offset)
        }
        
        // ARC - Automatic Reference Counting
        
        
        return cell
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
