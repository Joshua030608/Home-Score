//
//  AddEditHouseDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/29/20.
//

import UIKit

class CategoryScoresHouseDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var scoresDictionary = [Category : Int?]()
    fileprivate var editing = true
    fileprivate var keys = [Int]()
    fileprivate var newDict = [Int:Int]()
    
     init(scoresDictionary: [Category : Int?]?) {
        if let scoresDictionary = scoresDictionary {
            self.scoresDictionary = scoresDictionary
        } else {
            editing = false
        }
         super.init()
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.defaultCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        let category = Category.defaultCategories[indexPath.row]
        cell.nameLabel.text = category.name
        let score = scoresDictionary[category]
        let scoreString = (score == nil) ? "N/A" : "\(score!!)"
        cell.ratingLabel.text = scoreString
        return cell
    }
    
    
}
