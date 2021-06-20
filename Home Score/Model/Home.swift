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

class HomeStore {
    
    static let shared: HomeStore = HomeStore()
    
    fileprivate static let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    fileprivate static let fileName = "Homes.json"
    fileprivate static let url = HomeStore.documentsDirectoryURL.appendingPathComponent(HomeStore.fileName, isDirectory: false)
    
    var homes: [Home] = HomeStore.getHomes()
    
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
    
    func updateHomes(forNewCategory newCategory: Category) {
        for home in homes {
            home.categoryScores[newCategory.id] = Category.NAValue
        }
        saveHomes()
    }
    
    
    fileprivate func saveHomes() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(homes)
            if FileManager.default.fileExists(atPath: HomeStore.url.path) {
                try FileManager.default.removeItem(at: HomeStore.url)
            }
            let wasSuccesful = FileManager.default.createFile(atPath: HomeStore.url.path, contents: data, attributes: nil)
            print(wasSuccesful)
        } catch {
            print("ERROR:", error.localizedDescription)
        }
    }
    
    fileprivate static func getHomes() -> [Home] {
        
        guard FileManager.default.fileExists(atPath: HomeStore.url.path) else {
            return []
        }
        
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: HomeStore.url)
            let homes = try decoder.decode([Home].self, from: data)
            return homes
        } catch {
            print(error.localizedDescription)
            debugPrint(error)
            return []
        }
    }
}

class Home: Codable {
    enum CodingKeys: CodingKey {
        case id, title, address, notes, photos, categoryScores
    }
    var id: UUID
    var title: String
    var address: String
    var notes: String
    var photos: [UIImage]
    var categoryScores: [UUID : Int]
    var score: Double? {
        
        var scoreTotal = 0
        var scoreCount = 0
        for (categoryID, score) in self.categoryScores {
            for category in CategoryStore.shared.categories {
                if category.id == categoryID {
                    if score == Category.NAValue {
                        scoreTotal += score * category.weight.rawValue
                        scoreCount += 1
                    }
                }
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

    
    /* static func savedHomes() -> [Home] {
        return [
        Home(title: "Home 1", address: "100 Adreess Street, City, DE", notes: "Notes", photos: [UIImage(named: "download")!]),
            Home(title: "Home 2", address: "200 Adreess Street, City, DE", notes: "Notes", photos: []),
            Home(title: "Home 3", address: "300 Adreess Street, City, DE", notes: "Notes", photos: []),
            Home(title: "Home 4", address: "400 Adreess Street, City, DE", notes: "Notes", photos: [UIImage(named: "download")!]),
            Home(title: "Home 5", address: "500 Adreess Street, City, DE", notes: "Notes", photos: []),
        ]
    } */
    
    init (id: UUID? = nil, title: String, address: String, notes: String, photos: [UIImage], categoryScores: [UUID : Int]? = nil) {
        self.id = (id == nil) ? UUID() : id!
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
    
    public required init(from decoder: Decoder) throws {
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        address = try container.decode(String.self, forKey: .address)
        notes = try container.decode(String.self, forKey: .notes)
        let photoDatas = try container.decode([Data].self, forKey: .photos)
        photos = photoDatas.map{ UIImage(data: $0)! }
        categoryScores = try container.decode([UUID : Int].self, forKey: .categoryScores)
      
        
    }
    
    public func encode(to encoder: Encoder) throws {
        print(photos.count)
        print(categoryScores.count)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(address, forKey: .address)
        try container.encode(notes, forKey: .notes)
        try container.encode(photos.map { $0.pngData()! }, forKey: .photos)
        try container.encode(categoryScores, forKey: .categoryScores)
    }
    
    static func defaultCategoryScores() -> [UUID : Int]{
        var newCategoryScores = [UUID : Int]()
        for category in CategoryStore.shared.categories {
            if category.name == "Kitchen" {
                newCategoryScores[category.id] = 8
            } else {
                newCategoryScores[category.id] = Category.NAValue
            }
        }
        return newCategoryScores
    }
}

