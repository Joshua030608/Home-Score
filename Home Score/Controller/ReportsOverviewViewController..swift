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
        
        dataSource.didScrollHandler = { [weak self] (index, offset) in
            self?.handleCategoryScoresScroll(index: index, offset: offset)
            
        }
        
    }
    
    func handleCategoryScoresScroll(index: Int, offset: CGFloat) {
        for (cellIndex, visibleCell) in tableView.visibleCells.enumerated() {
            if index != cellIndex {
                let cell = visibleCell as! HouseCell
                //cell.collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
                // simultaneous gestures
                print("Something else")
            } else {
                print("HERE")
            }
        }
    }
    
    
    @IBAction func addHomeButtonPressed(_ sender: Any) {
        let addEditHouseVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditHouseViewController") as! AddEditHouseViewController
                navigationController?.pushViewController(addEditHouseVC, animated: true)
    }
    

}

extension ReportsOverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addEditHouseVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "AddEditHouseViewController") as! AddEditHouseViewController
        let home1 = Home.savedHomes()[indexPath.row]
        addEditHouseVC.home = home1
        navigationController?.pushViewController(addEditHouseVC, animated: true)
    }
}

