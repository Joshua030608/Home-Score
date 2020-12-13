//
//  AddEditHouseViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 11/17/20.
//

import UIKit
class AddEditHouseViewController: UIViewController {
    
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataSource: CategoryScoresHouseDataSource?
    
    var home: Home? {
        didSet {
            if let home = home {
                houseImageView.image = home.photos
                addressTextField.text = home.address
                titleTextField.text = home.title
                dataSource = CategoryScoresHouseDataSource(scoresDictionary: home.categoryScores)
                
            } else {
                dataSource = CategoryScoresHouseDataSource(scoresDictionary: nil)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
}
