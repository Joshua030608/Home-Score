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
    var categoryScores: [Category : Int]
    var score: Double? {
        
        var scoreTotal = 0
        var scoreCount = 0
        for (category, score) in self.categoryScores {
            if score != Category.NAValue {
                scoreTotal += score * category.weight
                scoreCount += 1
            }
        }
        
        if scoreCount == 0 {
            return nil
        }
        
        let average = Double(scoreTotal / scoreCount)
        let factor = 1.0 / Double(Category.maxWeight)
        let finalScore = factor * average
        return finalScore
        
        // |    |    |    |    |    |    |    |    |    |    |
    }

    static func savedHomes() -> [Home] {
        return [
        Home(title: "Home 1", address: "100 Adreess Street, City, DE", notes: "Notes", photos: UIImage(named: "download")),
            Home(title: "Home 2", address: "200 Adreess Street, City, DE", notes: "Notes", photos: nil),
            Home(title: "Home 3", address: "300 Adreess Street, City, DE", notes: "Notes", photos: nil),
            Home(title: "Home 4", address: "400 Adreess Street, City, DE", notes: "Notes", photos: UIImage(named: "download")),
            Home(title: "Home 5", address: "500 Adreess Street, City, DE", notes: "Notes", photos: nil),
        ]
    }
    
    init (title: String, address: String, notes: String, photos: UIImage?, categoryScores: [Category : Int]? = nil) {
        self.title = title
        self.address = address
        self.notes = notes
        self.photos = photos
        if let categoryScores = categoryScores {
            self.categoryScores = categoryScores
        } else {
            self.categoryScores = Home.defaultCategoryScores()
        }

    }
    
    static func defaultCategoryScores() -> [Category : Int]{
        var newCategoryScores = [Category : Int]()
        for category in Category.defaultCategories {
            if category.name == "Kitchen" {
                newCategoryScores[category] = 8
            } else {
                newCategoryScores[category] = Category.NAValue
            }
        }
        return newCategoryScores
    }
}

