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
    
    fileprivate let emptyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 200, weight: .regular)
        let image = UIImage(systemName: "house.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addHomeButtonPressedC), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Press Here To Add A House And Get Started!"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
     fileprivate var emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    
        
        
//        AddEditHouseViewController().didUpdateHomesHandler = { [weak self] () in
//            self?.reloadTableView()
//
//        }
        print(#file, #function)
        dataSource.updateImageIndices()
        setUpEmptyButton()
        if HomeStore.shared.homes.isEmpty {
            emptyView.removeFromSuperview()
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Used this to figure out that category is saved but just not showing up after app is closed.
    }
    
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
    
    func setUpEmptyButton() {
        emptyView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        emptyView.addSubview(emptyButton)
        emptyView.addSubview(emptyLabel)
        view.addSubview(emptyView)
        
        emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        emptyView.removeFromSuperview()
        
        emptyButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emptyButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        emptyButton.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyButton.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -160).isActive = true
        
        emptyLabel.topAnchor.constraint(equalTo: emptyButton.bottomAnchor, constant: 8).isActive = true
        emptyLabel.widthAnchor.constraint(equalToConstant: 225).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    @objc fileprivate func addHomeButtonPressedC() {
        let addEditHouseVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditHouseViewController") as! AddEditHouseViewController
        addEditHouseVC.newHouseAddedHandler = houseAdded(doesHaveAImage:)
        navigationController?.pushViewController(addEditHouseVC, animated: true)
    }
    
    @IBAction func addHomeButtonPressed(_ sender: Any) {
        addHomeButtonPressedC()
    }
    
    fileprivate func houseAdded(doesHaveAImage: Bool) {
        dataSource.imageIndices.append(doesHaveAImage ? 0 : nil)
    }
            
}

extension ReportsOverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let addEditHouseVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "AddEditHouseViewController") as! AddEditHouseViewController
        let home1 = HomeStore.shared.homes[indexPath.row]
        addEditHouseVC.home = home1
        
        navigationController?.pushViewController(addEditHouseVC, animated: true)
    }
}

