//
//  SettingsCategoryCell.swift
//  Home Score
//
//  Created by Joshua Ford on 4/13/21.
//

import UIKit

class SettingsCategoryCell: UITableViewCell {
    static let id = NSStringFromClass(SettingsCategoryCell.self)
 
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var weightSegmentedControl: UISegmentedControl!
    @IBAction func weightChanged(_ sender: Any) {
    }
    
}
