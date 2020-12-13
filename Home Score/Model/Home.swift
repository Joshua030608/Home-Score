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
    var categoryScores: [Category : Int?]
    var score: Int

    static func savedHomes() -> [Home] {
        return [
        Home(title: "Home 1", address: "100 Adreess Street, City, DE", notes: "Notes", photos: UIImage(named: "download"), score: 10),
            Home(title: "Home 2", address: "200 Adreess Street, City, DE", notes: "Notes", photos: nil, score: 9),
            Home(title: "Home 3", address: "300 Adreess Street, City, DE", notes: "Notes", photos: nil, score: 8),
            Home(title: "Home 4", address: "400 Adreess Street, City, DE", notes: "Notes", photos: UIImage(named: "download"), score: 7),
            Home(title: "Home 5", address: "500 Adreess Street, City, DE", notes: "Notes", photos: nil, score: 6),
        ]
    }
    
    init (title: String, address: String, notes: String, photos: UIImage?, categoryScores: [Category : Int?]? = nil, score: Int) {
        self.title = title
        self.address = address
        self.notes = notes
        self.photos = photos
        if let categoryScores = categoryScores {
            self.categoryScores = categoryScores
        } else {
            self.categoryScores = Home.defaultCategoryScores()
        }
        self.score = score
    }
    
    static func defaultCategoryScores() -> [Category : Int?]{
        var newCategoryScores = [Category : Int?]()
        for category in Category.defaultCategories {
            newCategoryScores[category] = nil
        }
        return newCategoryScores
    }
}

