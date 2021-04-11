//
//  SettingsViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 3/24/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    fileprivate enum SettingsOption: Int, CaseIterable {
        case categories = 0, weighting, termsOfUse, legal, privacyPolicy
        
        var name: String {
            switch self {
            case .categories: return "Categories"
            case .weighting: return "Weighting"
            case .termsOfUse: return "Terms Of Use"
            case .legal: return "Legal"
            case .privacyPolicy: return "Privacy Policy"
            }
        }
        
        var segueIdentifier: String {
            let baseSegueID: String
            switch self {
            case .categories: baseSegueID = "CustomCategory"
            case .weighting: baseSegueID =  "Weighting"
            case .termsOfUse, .legal, .privacyPolicy: baseSegueID =  "TextView"
            }
            return baseSegueID + "Segue"
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var settingsOption: SettingsOption?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let categoriesVC = segue.destination as? CustomCategoryViewController {
            
        } else if let weightingVC = segue.destination as? WeightingViewController {
            
        } else if let tvVC = segue.destination as? TextViewViewController {
            let textToReturn: String
            switch settingsOption! {
            case .termsOfUse: textToReturn =  LegalSettingsOption.termsOfUse.text
            case .legal: textToReturn =  LegalSettingsOption.legal.text
            case .privacyPolicy:  textToReturn = LegalSettingsOption.privacyPolicy.text
            default: textToReturn = ""
            }
            tvVC.text = textToReturn
        }
    }
}
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")!
        cell.textLabel?.text = SettingsOption(rawValue: indexPath.row)!.name
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / CGFloat(SettingsOption.allCases.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsOption = SettingsOption(rawValue: indexPath.row)!
        self.settingsOption = settingsOption
        performSegue(withIdentifier: settingsOption.segueIdentifier, sender: nil)
    }
}
