//
//  ViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 10/20/20.
//

import UIKit

class ReportsOverviewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataSource = HomeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    @IBAction func addHomeButtonPressed(_ sender: Any) {
        let addEditHouseVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditHouseViewController") as! AddEditHouseViewController
        addEditHouseVC.home = Home()
        navigationController?.pushViewController(addEditHouseVC, animated: true)
    }
    

}

extension ReportsOverviewViewController: UITableViewDelegate {
    
}

