//
//  Category.swift
//  Home ScoreTests
//
//  Created by Joshua Ford on 10/27/20.
//

import UIKit

/*categories: Struct
Name: String
weight: Int
photo UIImage
*/
class CategoryStore {
    
    static let shared: CategoryStore = CategoryStore()
    
    fileprivate static let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    fileprivate static let fileName = "Categories.json"
    fileprivate static let url = CategoryStore.documentsDirectoryURL.appendingPathComponent(CategoryStore.fileName, isDirectory: false)
    
    var categories: [Category] = CategoryStore.getCategories()
    
    fileprivate init() {
       // self.categories = CategoryStore.getCategories()
    }
    
    fileprivate static func getCategories() -> [Category] {
        
        guard FileManager.default.fileExists(atPath: CategoryStore.url.path) else {
            return Category.defaultCategories
        }
        
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: CategoryStore.url)
            let categories = try decoder.decode([Category].self, from: data)
            return categories
        } catch {
            print(error.localizedDescription)
            debugPrint(error)
            return []
        }
    }
    
    fileprivate func saveCategories() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(categories)
            if FileManager.default.fileExists(atPath: CategoryStore.url.path) {
                try FileManager.default.removeItem(at: CategoryStore.url)
            }
            FileManager.default.createFile(atPath: CategoryStore.url.path, contents: data, attributes: nil)
        } catch {
            print("ERROR:", error.localizedDescription)
        }
    }
}

struct Category: Codable {
    var name: String
    var weight: WeightOption
    var photo: UIImage?
    
    enum CodingKeys: CodingKey {
        case name, weight, photo
    }
    
    enum WeightOption: Int, Codable {
        case veryLow = 1, low, medium, high, veryHigh
        
        static let maxWeight: WeightOption = .veryHigh
        static let defaultWeight: WeightOption = .medium
    }
    
    static let NAValue = -1
    static let defaultCategories = [
        Category(name: "Kitchen", photo: nil),
        Category(name: "Master Bedroom", photo: nil),
        Category(name: "Master Bathroom", photo: nil),
        Category(name: "Other Bedrooms", photo: nil),
        Category(name: "Backyard", photo: nil),
        Category(name: "Frontyard", photo: nil),
        Category(name: "School District", photo: nil),
        Category(name: "Neighborhood", photo: nil),
        Category(name: "Living Room", photo: nil),
        Category(name: "Basement", photo: nil),
        Category(name: "Other Bathrooms", photo: nil),
        Category(name: "Driveway", photo: nil),
        Category(name: "Laundry Room", photo: nil),
        Category(name: "Garage", photo: nil)
    ]
    
        

    
    init(name: String, weight: WeightOption = WeightOption.defaultWeight, photo: UIImage?) {
        self.name = name
        self.weight = weight
        self.photo = photo
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        weight = try container.decode(Category.WeightOption.self, forKey: .weight)
        let photoData = try? container.decode(Data.self, forKey: .photo)
        if let photoData = photoData {
            photo = UIImage(data: photoData)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(weight, forKey: .weight)
        try container.encode(photo?.pngData(), forKey: .photo)
    }
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
