//
//  HomeDataSource.swift
//  Home Score
//
//  Created by Joshua Ford on 11/3/20.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
     
    var imageIndices: [Int?] = []
    
    var didScrollHandler: ((Int, CGFloat) -> Void)?
    
    override init() {
        super.init()
        createImageIndices()
    }
    
    func createImageIndices() {
        var indices: [Int?] = []
        for home in HomeStore.shared.homes {
            let index = (home.photos.isEmpty) ? nil : 0
            indices.append(index)
        }
        self.imageIndices = indices
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
        
        cell.images = home.photos
        print(HomeStore.shared.homes.count, imageIndices.count)
        cell.imageIndex = imageIndices[indexPath.row]
        cell.collectionView.dataSource = self
        cell.collectionView.reloadData()
        
        return cell
    }
    
    @objc fileprivate func imageViewPressed(gestureRecognizer: UITapGestureRecognizer) {
        let index = gestureRecognizer.view!.tag
        let imageView = gestureRecognizer.view as! UIImageView
        if let imageIndex = imageIndices[index] {
            let homePhotos = HomeStore.shared.homes[index].photos
            let imageIndex = (imageIndex + 1) % homePhotos.count
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
        
        // TODO: This
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

