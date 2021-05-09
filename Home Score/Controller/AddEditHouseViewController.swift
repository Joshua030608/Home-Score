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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
        if addressTextField.hasText && titleTextField.hasText && alreadyHaveData == false {
            HomeStore.shared.homes.append(home!)
            let reportsOverviewVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ReportsOverviewViewController") as! ReportsOverviewViewController
            navigationController?.pushViewController(reportsOverviewVC, animated: true)
        }
    }
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
    
   /* fileprivate func setUpCategoryScorePicker() {
        categoryScorePicker.translatesAutoresizingMaskIntoConstraints = false
        categoryScorePicker.backgroundColor = .systemPink
        categoryScorePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        categoryScorePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        categoryScorePicker.heightAnchor.constraint(equalToConstant: AddEditHouseViewController.categoryScorePickerHeight).isActive = true
        categoryScorePickerTopConstraint = categoryScorePicker.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint.isActive = true

    }
  */
    fileprivate func setUpPickerViewParent() {
        view.addSubview(pickerViewParent)
        pickerViewParent.backgroundColor = .systemPink
        pickerViewParent.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerViewParent.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pickerViewParent.heightAnchor.constraint(equalToConstant: AddEditHouseViewController.categoryScorePickerHeight).isActive = true
        //categoryScorePickerTopConstraint = categoryScorePicker.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint = pickerViewParent.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
        categoryScorePickerTopConstraint.isActive = true
    }
    
    fileprivate func setUpCustomFooter() {
        customFooter = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CategoryCell.height))
        tableView.tableFooterView = customFooter
    }
    
    fileprivate func setViewLayers() {
        //view.bringSubviewToFront(pickerParentView)
        view.bringSubviewToFront(pickerViewParent)
        //view.bringSubviewToFront(categoryScorePicker)
        view.bringSubviewToFront(blockerView)
        view.bringSubviewToFront(addressTextField)
        view.bringSubviewToFront(titleTextField)
        view.bringSubviewToFront(houseImageView)
        
    }
    
    @objc fileprivate func houseImageViewPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
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
        houseImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(houseImageViewPressed))
        houseImageView.addGestureRecognizer(tapGestureRecognizer)
        //setUpCategoryScorePicker()
        setUpCustomFooter()
        setUpBlockerView()
        setUpPickerViewParent()
        setViewLayers()
        tableView.dataSource = dataSource
        tableView.delegate = self
        pickerViewParent.isHidden = true
        pickerViewParent.delegate = self
    }
}

extension AddEditHouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        let category = dataSource?.category(forIndexPath: indexPath)
        let currentScore = dataSource?.score(forCategory: category!)
        let rowNumber = (currentScore == Category.NAValue) ? 0 : currentScore! + 1
        pickerViewParent.tag = indexPath.row
        pickerViewParent.selectPickerViewRow(for: rowNumber)
        pickerViewParent.reloadPickerView()
        pickerViewParent.isHidden = false
    
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
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return AddEditHouseViewController.categoryScorePickerHeight
    }

extension AddEditHouseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let selectedIndexPath = selectedIndexPath else { return }
    
        let moveDownBy = (CGFloat(selectedIndexPath.row + 1) * CategoryCell.height) - tableView.contentOffset.y
        
        print(tableView.contentOffset.y)
        categoryScorePickerTopConstraint.constant = moveDownBy
    }
}

extension AddEditHouseViewController: CategoryScorePickerViewParentDelegate {
    func updateScore(_ score: Int) {
        dataSource?.updateScore(forCategory: CategoryStore.shared.categories[pickerViewParent.tag], score: score)
        self.tableView.reloadData()
        pickerViewParent.tag = 0
        pickerViewParent.isHidden = true
    }
    func xButtonPressed() {
        pickerViewParent.isHidden = true
    }
}

extension AddEditHouseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            houseImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            houseImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
