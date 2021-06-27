//
//  AddEditHouseDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/29/20.
//

import UIKit

class CategoryScoresHouseDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var scoresDictionary = [UUID : Int]()
    fileprivate var keys = [Int]()
    fileprivate var newDict = [Int:Int]()
    
     init(scoresDictionary: [UUID : Int]?) {
        if let scoresDictionary = scoresDictionary {
            self.scoresDictionary = scoresDictionary
        } else {
            self.scoresDictionary = Home.defaultCategoryScores()
        }
         super.init()
     }
    
    func getAllScores() -> [UUID: Int] {
        return scoresDictionary
    }
    
    func updateScore(forCategory category: Category, score: Int) {
        scoresDictionary[category.id] = score
    }
    
    func score(forCategory category: Category) -> Int {
        print(#function)
        /*for  (index, score) in scoresDictionary.enumerated() {
            print(index, score.0.name, score.0.weight, score.1)
        }*/
        
        
        
        print(scoresDictionary)
        
        return scoresDictionary[category.id] ?? 1
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
        let score = scoresDictionary[category.id]
        print(category.id)
        
        for (id, scoreValue) in scoresDictionary {
            print("(\(id))score \(scoreValue)")
        }
        let scoreString = (score == Category.NAValue) ? "N/A" : "\(score!)"
        
        cell.ratingLabel.text = scoreString
        return cell
    }
    
    
}
