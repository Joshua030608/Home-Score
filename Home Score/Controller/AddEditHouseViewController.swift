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
    
    fileprivate static let categoryScorePickerHeight: CGFloat = 44.0
    fileprivate var categoryScorePickerTopConstraint: NSLayoutConstraint!
    fileprivate var customFooter: UIView!
    
    fileprivate var selectedIndexPath: IndexPath?
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
    
    fileprivate func setUpCategoryScorePicker() {
        categoryScorePicker.translatesAutoresizingMaskIntoConstraints = false
        
        categoryScorePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        categoryScorePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        categoryScorePicker.heightAnchor.constraint(equalToConstant: AddEditHouseViewController.categoryScorePickerHeight).isActive = true
        categoryScorePickerTopConstraint = categoryScorePicker.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint.isActive = true
    }
    
    fileprivate func setUpCustomFooter() {
        customFooter = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CategoryCell.height))
        tableView.tableFooterView = customFooter
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
        setUpCategoryScorePicker()
        setUpCustomFooter()
        tableView.dataSource = dataSource
        tableView.delegate = self
        categoryScorePicker.isHidden = true
    }
}

extension AddEditHouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        let category = dataSource?.category(forIndexPath: indexPath)
        let currentScore = dataSource?.score(forCategory: category!)
        let rowNumber = (currentScore == Category.NAValue) ? 0 : currentScore! + 1
        categoryScorePicker.tag = indexPath.row
        categoryScorePicker.selectRow(rowNumber, inComponent: 0, animated: true)
        categoryScorePicker.reloadAllComponents()
        categoryScorePicker.isHidden = false
    
        let moveDownBy = (CGFloat(selectedIndexPath!.row + 1) * CategoryCell.height) - tableView.contentOffset.y
        
        print(tableView.contentOffset.y)
        categoryScorePickerTopConstraint.constant = moveDownBy
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryCell.height
    }
}

extension AddEditHouseViewController: UIPickerViewDataSource {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 12
    }

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if row == 0 {
        return "N/A"
    } else {
        let correctNumber = row - 1
        return String(correctNumber)
        }
    }
}

extension AddEditHouseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Tried using titleForRowAt but didn't work.
        let newScore = (row == 0) ? Category.NAValue : row - 1
        dataSource?.updateScore(forCategory: Category.defaultCategories[pickerView.tag], score: newScore)
        self.tableView.reloadData()
        pickerView.tag = 0
        pickerView.isHidden = true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return AddEditHouseViewController.categoryScorePickerHeight
    }
}

extension AddEditHouseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let selectedIndexPath = selectedIndexPath else { return }
    
        let moveDownBy = (CGFloat(selectedIndexPath.row + 1) * CategoryCell.height) - tableView.contentOffset.y
        
        print(tableView.contentOffset.y)
        categoryScorePickerTopConstraint.constant = moveDownBy
    }
}
