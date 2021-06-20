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
    
    func category(forID id: UUID) -> Category? {
        for category in categories {
            if category.id == id {
                return category
            }
        }
        return nil
    }
    
    func addCategory(_ category: Category) {
        categories.append(category)
        saveCategories()
        HomeStore.shared.updateHomes(forNewCategory: category)
    }
    
    func updateName(_ name: String, forCategoryAtIndex categoryIndex: Int) {
        categories[categoryIndex].name = name // Struct (value)
        saveCategories()
        
    }
    
    func updateWeight(_ weight: Category.WeightOption, forCategoryAtIndex categoryIndex: Int) {
        print("Before", categories[categoryIndex].weight)
        categories[categoryIndex].weight = weight // Struct (value)
        print("After", categories[categoryIndex].weight)
        saveCategories()
    }
    
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
            print(#function)
            for  (index, category) in categories.enumerated() {
                print(index, category.name, category.weight)
            }
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
    let id: UUID
    var name: String
    var weight: WeightOption
    var photo: UIImage?
    
    enum CodingKeys: CodingKey {
        case id, name, weight, photo
    }
    
    enum WeightOption: Int, Codable {
        case veryLow = 1, low, medium, high, veryHigh
        
        static let maxWeight: WeightOption = .veryHigh
        static let defaultWeight: WeightOption = .medium
    }
    
    static let NAValue = -1
    static let defaultCategories = [
        Category(id: UUID(), name: "Kitchen", photo: nil),
        Category(id: UUID(), name: "Master Bedroom", photo: nil),
        Category(id: UUID(), name: "Master Bathroom", photo: nil),
        Category(id: UUID(), name: "Other Bedrooms", photo: nil),
        Category(id: UUID(), name: "Backyard", photo: nil),
        Category(id: UUID(), name: "Frontyard", photo: nil),
        Category(id: UUID(), name: "School District", photo: nil),
        Category(id: UUID(), name: "Neighborhood", photo: nil),
        Category(id: UUID(), name: "Living Room", photo: nil),
        Category(id: UUID(), name: "Basement", photo: nil),
        Category(id: UUID(), name: "Other Bathrooms", photo: nil),
        Category(id: UUID(), name: "Driveway", photo: nil),
        Category(id: UUID(), name: "Laundry Room", photo: nil),
        Category(id: UUID(), name: "Garage", photo: nil)
    ]
    
        

    
    init(id: UUID, name: String, weight: WeightOption = WeightOption.defaultWeight, photo: UIImage?) {
        self.id = id
        self.name = name
        self.weight = weight
        self.photo = photo
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        weight = try container.decode(Category.WeightOption.self, forKey: .weight)
        let photoData = try? container.decode(Data.self, forKey: .photo)
        if let photoData = photoData {
            photo = UIImage(data: photoData)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(weight, forKey: .weight)
        try container.encode(photo?.pngData(), forKey: .photo)
    }
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
