//
//  AddEditHouseDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/29/20.
//

import UIKit

class AddEditHouseDataSource: NSObject, UITableViewDataSource {
    
     var homes: [Home]
     
     override init() {
         homes = Home.savedHomes()
         super.init()
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
