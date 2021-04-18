//
//  CategoryViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 3/24/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoriesAdded = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Category.allCategories.count + 1 + categoriesAdded.count // 1 for the adding cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCategoryCell.id, for: indexPath) as! SettingsCategoryCell
        cell.selectionStyle = .none
        
        if indexPath.row < Category.allCategories.count + categoriesAdded.count {
            cell.categoryLabel.text = Category.allCategories[indexPath.row].name
            cell.categoryLabel.isUserInteractionEnabled = false
            cell.weightSegmentedControl.selectedSegmentIndex = Category.allCategories[indexPath.row].weight.rawValue - 1
        } else {
            cell.categoryLabel.text = "+ Add New Category"
            cell.categoryLabel.isUserInteractionEnabled = true
            cell.weightSegmentedControl.selectedSegmentIndex = Category.WeightOption.defaultWeight.rawValue - 1
            cell.categoryLabel.delegate = self
        }
        
        // isUserInteractionEnabled
        return cell
    }
    
    
}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        categoriesAdded.append(Category(name: textField.text ?? "How Did We Get Here?", photo: nil))
    }
}
