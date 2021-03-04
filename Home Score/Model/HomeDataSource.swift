//
//  HomeDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
    var homes: [Home]
    
    override init() {
        homes = Home.savedHomes()
        super.init()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseCell.id, for: indexPath) as! HouseCell
        let home = homes[indexPath.row]
//        cell.titleLabel.text = home.title
//        cell.homeScoreLabel.text = String(home.score)
        let attributedText = NSMutableAttributedString(string: home.title + "\n", attributes: [.font : UIFont.systemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "$1,000,000", attributes: [.font: UIFont.systemFont(ofSize: 10)]))
        cell.label.attributedText = attributedText
        cell.houseImageView.image = home.photos
        return cell
    }
}
