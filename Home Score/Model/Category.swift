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
struct Category {
    let name: String
    var weight: Int
    var photo: UIImage?
    
    static let NAValue = -1
    static let maxWeight = 10
    static let defaultWeight = 1
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
    init(name: String, weight: Int = Category.defaultWeight, photo: UIImage?) {
        self.name = name
        self.weight = weight
        self.photo = photo
    }
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
