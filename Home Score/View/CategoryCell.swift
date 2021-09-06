//
//  CategoryCell.swift
//  Home Score
//
//  Created by Joshua Ford on 11/17/20.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let id = NSStringFromClass(CategoryCell.self)
    static let height = CGFloat(44)
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
