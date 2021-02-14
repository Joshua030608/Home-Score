//
//  CategoryScorePickerViewParent.swift
//  Home Score
//
//  Created by Joshua Ford on 1/26/21.
//
import UIKit

protocol CategoryScorePickerViewParentDelegate: class {
    func updateScore(_ score: Int)
    func xButtonPressed()
}

class CategoryScorePickerViewParent: UIView {
    
    //var xButtonPressedHandler: (() -> Void)?
    fileprivate let categoryScorePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    fileprivate let xButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CategoryScorePickerViewParentDelegate?
    
    fileprivate func setUpLayout() {
        categoryScorePicker.widthAnchor.constraint(equalToConstant: 70).isActive = true
        categoryScorePicker.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryScorePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        categoryScorePicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        xButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        xButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        xButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        xButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func reloadPickerView() {
        categoryScorePicker.reloadAllComponents()
    }
    
    func selectPickerViewRow(for row: Int ) {
        categoryScorePicker.selectRow(row, inComponent: 0, animated: true)
    }
    
    @objc func buttonPressed() {
        delegate?.xButtonPressed()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryScorePicker)
        addSubview(xButton)
        categoryScorePicker.dataSource = self
        categoryScorePicker.delegate = self
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryScorePickerViewParent: UIPickerViewDataSource {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 12
    }
}

extension CategoryScorePickerViewParent: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Tried using titleForRowAt but didn't work.
        let newScore = (row == 0) ? Category.NAValue : row - 1
        delegate!.updateScore(newScore)
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
