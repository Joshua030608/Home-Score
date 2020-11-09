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
    var score: Int
    
    static func savedHomes() -> [Home] {
        return [
        Home(title: "Home 1", address: "100 Adreess Street, City, DE", notes: "Notes", photos: UIImage(named: "download"), categories: [Category : Int](), score: 10),
            Home(title: "Home 2", address: "200 Adreess Street, City, DE", notes: "Notes", photos: nil, categories: [Category : Int](), score: 9),
            Home(title: "Home 3", address: "300 Adreess Street, City, DE", notes: "Notes", photos: nil, categories: [Category : Int](), score: 8),
            Home(title: "Home 4", address: "400 Adreess Street, City, DE", notes: "Notes", photos: UIImage(named: "download"), categories: [Category : Int](), score: 7),
            Home(title: "Home 5", address: "500 Adreess Street, City, DE", notes: "Notes", photos: nil, categories: [Category : Int](), score: 6),
        ]
    }
    
    init (title: String, address: String, notes: String, photos: UIImage?, categories: [Category : Int], score: Int) {
        self.title = title
        self.address = address
        self.notes = notes
        self.photos = photos
        self.categories = categories
        self.score = score
    }
    
    
}

