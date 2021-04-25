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
        CategoryStore.shared.categories.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCategoryCell.id, for: indexPath) as! SettingsCategoryCell
        cell.selectionStyle = .none
        
        if indexPath.row < CategoryStore.shared.categories.count {
            cell.categoryLabel.text = CategoryStore.shared.categories[indexPath.row].name
            cell.categoryLabel.isUserInteractionEnabled = false
            cell.weightSegmentedControl.selectedSegmentIndex = CategoryStore.shared.categories[indexPath.row].weight.rawValue - 1
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
        CategoryStore.shared.categories.append(Category(name: textField.text ?? "How Did We Get Here?", photo: nil))
    }
}
