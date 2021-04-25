//
//  AddEditHouseDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/29/20.
//

import UIKit

class CategoryScoresHouseDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var scoresDictionary = [Category : Int]()
    fileprivate var keys = [Int]()
    fileprivate var newDict = [Int:Int]()
    
     init(scoresDictionary: [Category : Int]?) {
        if let scoresDictionary = scoresDictionary {
            self.scoresDictionary = scoresDictionary
        } else {
            self.scoresDictionary = Home.defaultCategoryScores()
        }
         super.init()
     }
    
    func updateScore(forCategory category: Category, score: Int) {
        scoresDictionary[category] = score
        //Can't update actually home because inside func?
    }
    
    func score(forCategory category: Category) -> Int {
        return scoresDictionary[category]!
    }

    func category(forIndexPath indexPath: IndexPath) -> Category {
        return CategoryStore.shared.categories[indexPath.row]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryStore.shared.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        let category = self.category(forIndexPath: indexPath)
        cell.nameLabel.text = category.name
        let score = scoresDictionary[category]
        let scoreString = (score == Category.NAValue) ? "N/A" : "\(score!)"
        cell.ratingLabel.text = scoreString
        return cell
    }
    
    
}
