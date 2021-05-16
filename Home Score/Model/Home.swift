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

class HomeStore /*codable*/ {
  /*
    enum CodingKeys: CodingKey {
        case id, title, address, notes, photos, categoryScores, score
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        
    }
    */
    static let shared: HomeStore = HomeStore()
    
    fileprivate static let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    fileprivate static let fileName = "Homes.json"
    fileprivate static let url = HomeStore.documentsDirectoryURL.appendingPathComponent(HomeStore.fileName, isDirectory: false)
    
    var homes: [Home] = Home.savedHomes()
    
    func saveHome(_ homeToSave: Home) {
        var matchingHomeFound = false
        for (index, home) in homes.enumerated() {
            if home.id == homeToSave.id {
                homes[index] = homeToSave
                matchingHomeFound = true
                break
            }
        }
        
        if matchingHomeFound == false {
            homes.append(homeToSave)
        }
        saveHomes()
        
    }
    
    fileprivate func saveHomes() {
//        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(categories)
//            if FileManager.default.fileExists(atPath: CategoryStore.url.path) {
//                try FileManager.default.removeItem(at: CategoryStore.url)
//            }
//            FileManager.default.createFile(atPath: CategoryStore.url.path, contents: data, attributes: nil)
//        } catch {
//            print("ERROR:", error.localizedDescription)
//        }
    }
    
    fileprivate static func getHomes() -> [Home] {
        guard FileManager.default.fileExists(atPath: HomeStore.url.path) else {
            return []
        }
        return []
    }
    
}

class CodableHomeStore: HomeStore, Codable {
    enum CodingKeys: CodingKey {
        case id, title, address, notes, photos, categoryScores, score
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        for home in homes {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            home.id = try container.decode(UUID.self, forKey: .id)
            home.title = try container.decode(String.self, forKey: .title)
            home.address = try container.decode(String.self, forKey: .address)
            home.notes = try container.decode(String.self, forKey: .notes)
            /* home.photos = try container.decode(UIImage.self, forKey: .photos)
            home.categoryScores = try container.decode([Category : Int].self, forKey: .categoryScores)
             */
            //home.score = try container.decode(Double.self, forKey: .score)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        for home in homes {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(home.id, forKey: .id)
            try container.encode(home.title, forKey: .title)
            try container.encode(home.address, forKey: .address)
            try container.encode(home.notes, forKey: .notes)
            /* try container.encode(home.photos, forKey: .photos)
            try container.encode(home.categoryScores, forKey: .categoryScores) */
            try container.encode(home.score, forKey: .score)
       }
    }
}
class Home {
    var id = UUID()
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
                scoreTotal += score * category.weight.rawValue
                scoreCount += 1
            }
        }
        
        if scoreCount == 0 {
            return nil
        }
        
        let average = (scoreTotal / scoreCount)
        let factor = 1.0 / Double(Category.WeightOption.maxWeight.rawValue)
        let finalScore = factor * Double(average)
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
        for category in CategoryStore.shared.categories {
            if category.name == "Kitchen" {
                newCategoryScores[category] = 8
            } else {
                newCategoryScores[category] = Category.NAValue
            }
        }
        return newCategoryScores
    }
}

