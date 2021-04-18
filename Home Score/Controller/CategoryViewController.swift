//
//  CategoryViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 3/24/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Category.allCategories.count + 1 // 1 for the adding cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCategoryCell.id, for: indexPath) as! SettingsCategoryCell
        cell.categoryLabel.text = Category.defaultCategories[indexPath.row].name
        cell.weightSegmentedControl.selectedSegmentIndex = Category.allCategories[indexPath.row].weight.rawValue
        return cell
    }
    
    
}
