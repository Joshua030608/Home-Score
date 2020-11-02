//
//  House.swift
//  Home Score
//
//  Created by Joshua Ford on 10/27/20.
//

import UIKit
/*
 houses: Class
     title: String
     address: String
     notes: String
     photos UIImage
     categories: [category : Int]
 */
class Home {
    var title: String
    var address: String
    var notes: String
    var photos: UIImage?
    var categories: [Category : Int]
    
    init (title: String, address: String, notes: String, photos: UIImage, categories: [Category : Int]) {
        self.title = title
        self.address = address
        self.notes = notes
        self.photos = photos
        self.categories = categories
    }
}

