//
//  HomeDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
    var homes: [Home]
    
    override init() {
        homes = Home.savedHomes()
        super.init()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
