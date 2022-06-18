//
//  HomeDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
     
    fileprivate var imageIndices: [Int?] = []
    
    var didScrollHandler: ((Int, CGFloat) -> Void)?
    var didSelectHome: ((Int) -> Void)?
    var didDeleteHome: ((Int) -> Void)?
    
    //weak var myCreator: UIViewController!
    
    override init() {
        super.init()
        createImageIndices()
    }
    
    
    fileprivate func createImageIndices() {
        var indices: [Int?] = []
        for home in HomeStore.shared.homes {
            let index = (home.photos.isEmpty) ? nil : 0
            indices.append(index)
        }
        
        self.imageIndices = indices
    }
    
    func updateForHousesUpdate(atHouseIndex houseIndex: Int) {
        imageIndices.remove(at: houseIndex)
    }
    
    func updateForImagesUpdate() {
        for (houseIndex, imageIndex) in imageIndices.enumerated() {
            print(houseIndex)
            print("THIS IS WHERE THE PROBLEM IS. THIS FOR LOOP IS RUNNING TOO MANY TIMES")
            print(HomeStore.shared.homes.count)
            let photosCount = HomeStore.shared.homes[houseIndex].photos.count
            if let imageIndex = imageIndex {
                if photosCount <= imageIndex {
                    imageIndices[houseIndex] = (photosCount > 0) ? photosCount - 1 : nil
                }
            } else {
                imageIndices[houseIndex] = (photosCount > 0) ? 0 : nil
            }
        }
    }
    
    func addHouse(withImage: Bool) {
        imageIndices.append(withImage ? 0 : nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(HomeStore.shared.homes.count)
        
        return HomeStore.shared.homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseCell.id, for: indexPath) as! HouseCell
        
        let home = HomeStore.shared.homes[indexPath.row]
        
        cell.didScrollHandler = { [weak self] (index, offset) in
            self?.didScrollHandler?(index, offset)
        }
        
        cell.setLabelText(score: home.score, price: home.price, address: home.address)
        
        cell.images = home.orderedPhotos
        print(#file, #function, HomeStore.shared.homes.count, imageIndices.count)
        cell.imageIndex = imageIndices[indexPath.row]
        cell.collectionView.dataSource = self
        cell.collectionView.reloadData()
        
//        cell.editButton.tag = indexPath.row
        cell.didSelectHomeHandler = { [weak self] in
            self?.didSelectHome?(indexPath.row)
        }
        
        cell.didDeleteHomeHandler = { [weak self] in
            self?.didDeleteHome?(indexPath.row)
        }
        cell.deleteButton.tag = indexPath.row
        //cell.controller = myCreator

        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc fileprivate func imageViewPressed(gestureRecognizer: UITapGestureRecognizer) {
        let index = gestureRecognizer.view!.tag
        let imageView = gestureRecognizer.view as! UIImageView
        if let imageIndex = imageIndices[index] {
            let homePhotos = Array(HomeStore.shared.homes[index].photos.values)
            let imageIndex = (imageIndex + 1) % homePhotos.count
            print("imageIndex:", imageIndex)
            imageIndices[index] = imageIndex
            imageView.image = homePhotos[imageIndex]
        }
    }
}

extension HomeDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryStore.shared.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompareCell.id, for: indexPath) as! CompareCell
        let home = HomeStore.shared.homes[collectionView.tag]
        let CategoryDataSource = CategoryScoresHouseDataSource(scoresDictionary: home.categoryScores)
        let category = CategoryDataSource.category(forIndexPath: indexPath)
        let score = CategoryDataSource.score(forCategory: category)
        cell.titleLabel.text = category.name
    
        cell.scoreLabel.text = (score == Category.NAValue) ? "N/A" : "\(score)"
        return cell
    }
}


extension HomeDataSource {
    
    func addImage(forHomeAtIndex homeIndex: Int) {
        if imageIndices[homeIndex] == nil {
            imageIndices[homeIndex] = 0
        }
    }
    
    func deleteImage(atIndex imageIndex: Int, forHomeAtIndex homeIndex: Int) {
        
        guard let shownImageIndex = imageIndices[homeIndex] else {
            print(#function, "trying to delete image that does not exist")
            return
        }
        
        if HomeStore.shared.homes[homeIndex].photos.count == 1 {
            imageIndices[homeIndex] = nil
            return
        }
        // homework here
        if imageIndex <= shownImageIndex {
            imageIndices[homeIndex]! = max(0, imageIndices[homeIndex]! - 1)
            return
        }
    }
}

