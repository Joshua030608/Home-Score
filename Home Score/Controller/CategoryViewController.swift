//
//  CategoryViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 3/24/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var addingCellWeight = Category.WeightOption.defaultWeight
 
    func weightChanged(forIndex index: Int, weight: Category.WeightOption) {
        if index < CategoryStore.shared.categories.count {
            CategoryStore.shared.categories[index].weight = weight
        } else {
            addingCellWeight = weight
        }
        
        
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CategoryStore.shared.categories.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCategoryCell.id, for: indexPath) as! SettingsCategoryCell
        cell.selectionStyle = .none
        cell.categoryLabel.tag = indexPath.row
        cell.weightChangedHandler = { [weak self] (newWeight) in
            self?.weightChanged(forIndex: indexPath.row, weight: newWeight)
        }
        if indexPath.row < CategoryStore.shared.categories.count {
            
            cell.categoryLabel.text = CategoryStore.shared.categories[indexPath.row].name
            cell.categoryLabel.isUserInteractionEnabled = false
            cell.weightSegmentedControl.selectedSegmentIndex = CategoryStore.shared.categories[indexPath.row].weight.rawValue - 1
            
            if indexPath.row >= Category.defaultCategories.count {
                cell.categoryLabel.isUserInteractionEnabled = true
            }
        } else {
            cell.categoryLabel.text = ""
            cell.categoryLabel.placeholder = "+ Add New Category"
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
            
        guard textField.hasText else { return }

        let row = textField.tag
        if row == CategoryStore.shared.categories.count {
            let newCategory = Category(name: textField.text!, weight: addingCellWeight, photo: nil)
            CategoryStore.shared.categories.append(newCategory)
        } else {
            CategoryStore.shared.categories[row].name = textField.text!
        }
        tableView.reloadData()
    }
}
