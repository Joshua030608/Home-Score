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
    @IBOutlet weak var categoryScorePicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataSource: CategoryScoresHouseDataSource?
    fileprivate var alreadyHaveData = false
    var home: Home? { // Problem was home wasn't being set when was nil.
        didSet {
            if let home = home {
                /*
                houseImageView.image = home.photos!
                addressTextField.text = home.address
                titleTextField.text = home.title
                dataSource = CategoryScoresHouseDataSource(scoresDictionary: home.categoryScores)
 */
            alreadyHaveData = true
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if alreadyHaveData {
            houseImageView.image = home!.photos
            addressTextField.text = home!.address
            titleTextField.text = home!.title
            dataSource = CategoryScoresHouseDataSource(scoresDictionary: home!.categoryScores)
        } else {
            dataSource = CategoryScoresHouseDataSource(scoresDictionary: nil)
        }
        tableView.dataSource = dataSource
        tableView.delegate = self
        categoryScorePicker.isHidden = true
    }
}

extension AddEditHouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = dataSource?.category(forIndexPath: indexPath)
        let currentScore = dataSource?.score(forCategory: category!)
        let rowNumber = (currentScore == nil) ? 0 : currentScore!
        categoryScorePicker.selectRow(rowNumber, inComponent: 0, animated: true)
        categoryScorePicker.reloadAllComponents()
        categoryScorePicker.isHidden = false
    }
}

extension AddEditHouseViewController: UIPickerViewDataSource {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 11
    }

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if row == 0 {
        return "N/A"
    } else {
        let correctNumber = row
        return String(correctNumber)
        }
    }
}

extension AddEditHouseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Dissapears automatically because stopping on a row is selecting?
        pickerView.isHidden = true
    }
}
