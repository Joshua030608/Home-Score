//
//  CategoryViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 3/24/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    fileprivate var addingCellWeight = Category.WeightOption.defaultWeight
 
    @IBAction func saveButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustFooter(isShowingKeyboard: false)
    }
    
    fileprivate func adjustFooter(isShowingKeyboard: Bool) {
        let height: CGFloat = isShowingKeyboard ? 275 : 0
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: height))
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.frame.size.height - height)
        }, completion: nil)
    }
    
    
    func weightChanged(forIndex index: Int, weight: Category.WeightOption) {
        if index < CategoryStore.shared.categories.count {
            CategoryStore.shared.updateWeight(weight, forCategoryAtIndex: index)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        print(indexPath.row)
        if indexPath.row == CategoryStore.shared.categories.count {
            print("false")
            return false
        } else {
            print("true")
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CategoryStore.shared.removeCategory(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension CategoryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        adjustFooter(isShowingKeyboard: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            
        guard textField.hasText else { return }

        let index = textField.tag
        if index == CategoryStore.shared.categories.count {
            let newCategory = Category(id: UUID(), name: textField.text!, weight: addingCellWeight, photo: nil)
            CategoryStore.shared.addCategory(newCategory)
        } else {
            CategoryStore.shared.updateName(textField.text!, forCategoryAtIndex: index)
        }
        adjustFooter(isShowingKeyboard: false)
        tableView.reloadData()
    }
}
