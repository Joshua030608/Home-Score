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
    fileprivate static let jsonURL = HomeStore.documentsDirectoryURL.appendingPathComponent(HomeStore.fileName, isDirectory: false)
    
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
        
        for id in homeToSave.photoIDs {
            if saveImage(homeToSave.photos[id]!, forID: id) {
                print("Be Happy!")
            } else {
                fatalError("be thankful it crashed and u know why")
            }
        }
    }
    
    func saveImage(_ image: UIImage, forID id: UUID) -> Bool {
        
        guard let data = image.pngData() else { return false }
        
        do {
            try data.write(to: HomeStore.documentsDirectoryURL.appendingPathComponent("\(id.uuidString).png"))
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func updateHomes(forNewCategory newCategory: Category) {
        for home in homes {
            home.categoryScores[newCategory.id] = Category.NAValue
        }
        saveHomes()
    }
    
    func updateHomes(forRemovedCategoryID removedCategoryID: UUID) {
         for home in HomeStore.shared.homes {
            home.categoryScores.removeValue(forKey: removedCategoryID)
        }
        saveHomes()
    }
    
    fileprivate func saveHomes() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(homes)
            if FileManager.default.fileExists(atPath: HomeStore.jsonURL.path) {
                try FileManager.default.removeItem(at: HomeStore.jsonURL)
            }
            let wasSuccesful = FileManager.default.createFile(atPath: HomeStore.jsonURL.path, contents: data, attributes: nil)
            print(wasSuccesful)
        } catch {
            print("ERROR:", error.localizedDescription)
        }
    }
    
    fileprivate static func getHomes() -> [Home] {
        
        guard FileManager.default.fileExists(atPath: HomeStore.jsonURL.path) else {
            return []
        }
        
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: HomeStore.jsonURL)
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
        case id, price, title, address, notes, photoIDs, categoryScores
    }
    var id: UUID
    var price: String
    var title: String
    var address: String
    var notes: String
    var photoIDs: [UUID]
    var photos: [UUID : UIImage]
    var categoryScores: [UUID : Int]
    var score: Double? {
        
        var scoreTotal = 0
        var scoreCount = 0
        var weightTotal = 0
        for (categoryID, score) in self.categoryScores {
            if score != Category.NAValue {
                let weight = CategoryStore.shared.category(forID: categoryID)!.weight.rawValue
                weightTotal += weight
                scoreTotal += score * weight
                scoreCount += 1
            }
        }
        
        if scoreCount == 0 {
            return nil
        }
        
        return Double(scoreTotal) / Double(weightTotal)
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
    
    init (id: UUID? = nil, title: String, price: String, address: String, notes: String, photos: [UIImage], categoryScores: [UUID : Int]? = nil) {
        self.id = (id == nil) ? UUID() : id!
        self.price = price
        self.title = title
        self.address = address
        self.notes = notes
        self.photos = [:]
        self.photoIDs = []
        for image in photos {
            let id = UUID()
            self.photos[id] = image
            self.photoIDs.append(id)
        }
        if let categoryScores = categoryScores {
            self.categoryScores = categoryScores
        } else {
            self.categoryScores = Home.defaultCategoryScores()
        }
        
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        price = try container.decode(String.self, forKey: .price)
        title = try container.decode(String.self, forKey: .title)
        address = try container.decode(String.self, forKey: .address)
        notes = try container.decode(String.self, forKey: .notes)
        photoIDs = try container.decode([UUID].self, forKey: .photoIDs)
        categoryScores = try container.decode([UUID : Int].self, forKey: .categoryScores)
        photos = [:]
        
        for photoID in photoIDs {
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let url = documentsDirectoryURL.appendingPathComponent("\(photoID.uuidString).png", isDirectory: false)
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                photos[photoID] = image
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(price, forKey: .price)
        try container.encode(title, forKey: .title)
        try container.encode(address, forKey: .address)
        try container.encode(notes, forKey: .notes)
        try container.encode(photoIDs, forKey: .photoIDs)
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

