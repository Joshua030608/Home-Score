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
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    

   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let categoriesVC = segue.destination as? CCVC {
            categoriesVC.data = interestinData
        } else if let weightingVC = segue.detination as? WVC {
            
        }
    }
     */
    
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
    
    
}
