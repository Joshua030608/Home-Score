//
//  SettingsCategoryCell.swift
//  Home Score
//
//  Created by Joshua Ford on 4/13/21.
//

import UIKit

class SettingsCategoryCell: UITableViewCell {
 
    static let id = "SettingsCategoryCell"
 
    var weightChangedHandler: ((Category.WeightOption) -> Void)?
    
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var weightSegmentedControl: UISegmentedControl!
    @IBAction func weightChanged(_ sender: Any) {
        let weight = Category.WeightOption(rawValue: weightSegmentedControl.selectedSegmentIndex + 1)
        self.weightChangedHandler?(weight!)
    }
    
}
