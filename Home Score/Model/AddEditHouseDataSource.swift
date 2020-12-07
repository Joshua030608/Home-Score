//
//  AddEditHouseDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/29/20.
//

import UIKit

class CategoryScoresHouseDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var scoresDictionary = [Category : Int]()
    fileprivate var editing = true
    fileprivate var keys = [Int]()
    fileprivate var newDict = [Int:Int]()
    
     init(scoresDictionary: [Category : Int]?) {
        if let scoresDictionary = scoresDictionary {
            self.scoresDictionary = scoresDictionary
        } else {
            editing = false
        }
         super.init()
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if editing {
            let keys2 = scoresDictionary.keys
            
            return scoresDictionary.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if editing {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
            cell.nameLabel.text = ""
            cell.ratingLabel.text = ""
        } else {
            return UITableViewCell()
        }
    }
    
    
}
