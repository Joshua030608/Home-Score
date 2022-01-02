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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    
        
        
//        AddEditHouseViewController().didUpdateHomesHandler = { [weak self] () in
//            self?.reloadTableView()
//
//        }
        dataSource.updateImageIndices()
        if HomeStore.shared.homes.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
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
        setUpEmptyButton()
        self.navigationItem.title = "myHomeScore"
        //dataSource.myCreator = self
        dataSource.didSelectHome = { [weak self] index in
            self?.editButtonPressedForHouseAt(index)
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
        
        view.addSubview(emptyView)
        emptyView.addSubview(emptyButton)
        emptyView.addSubview(emptyLabel)
        
        emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        emptyView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
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
    
    func editButtonPressedForHouseAt(_ houseIndex: Int) {
        let addEditHouseVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditHouseViewController") as! AddEditHouseViewController
        let home1 = HomeStore.shared.homes[houseIndex]
        addEditHouseVC.home = home1
        navigationController?.pushViewController(addEditHouseVC, animated: true)
    }
}

