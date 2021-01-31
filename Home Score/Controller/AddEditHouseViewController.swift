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
    @IBOutlet weak var pickerParentView: UIView!
    
    fileprivate static let categoryScorePickerHeight: CGFloat = 44.0
    fileprivate var categoryScorePickerTopConstraint: NSLayoutConstraint!
    fileprivate var customFooter: UIView!
    fileprivate let blockerView: UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = .systemBackground
        return bv
    }()
    fileprivate let pickerViewParent: CategoryScorePickerViewParent = {
        let view = CategoryScorePickerViewParent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
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
    fileprivate func setUpBlockerView() {
        view.addSubview(blockerView)
        
        blockerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        blockerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        blockerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        blockerView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    }
    
    fileprivate func setUpCategoryScorePicker() {
        categoryScorePicker.translatesAutoresizingMaskIntoConstraints = false
        categoryScorePicker.backgroundColor = .systemPink
        categoryScorePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        categoryScorePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        categoryScorePicker.heightAnchor.constraint(equalToConstant: AddEditHouseViewController.categoryScorePickerHeight).isActive = true
        categoryScorePickerTopConstraint = categoryScorePicker.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint.isActive = true

    }
    
    fileprivate func setUpPickerParentView() {
        pickerParentView.translatesAutoresizingMaskIntoConstraints = false
        pickerParentView.backgroundColor = .systemPink
        pickerParentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerParentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pickerParentView.heightAnchor.constraint(equalToConstant: AddEditHouseViewController.categoryScorePickerHeight).isActive = true
        categoryScorePickerTopConstraint = categoryScorePicker.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint = pickerParentView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint.isActive = true
    }
    
    fileprivate func setUpCustomFooter() {
        customFooter = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CategoryCell.height))
        tableView.tableFooterView = customFooter
    }
    
    fileprivate func setViewLayers() {
        view.bringSubviewToFront(pickerParentView)
        view.bringSubviewToFront(categoryScorePicker)
        view.bringSubviewToFront(blockerView)
        view.bringSubviewToFront(addressTextField)
        view.bringSubviewToFront(titleTextField)
        view.bringSubviewToFront(houseImageView)
        
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
        setUpBlockerView()
        setUpPickerParentView()
        setViewLayers()
        tableView.dataSource = dataSource
        tableView.delegate = self
        pickerParentView.isHidden = true
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
        pickerParentView.isHidden = false
    
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
        pickerParentView.isHidden = true
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
