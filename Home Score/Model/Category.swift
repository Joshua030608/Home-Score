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
    static let defaultCategories = [
        Category(name: "Kitchen", weight: 9, photo: nil),
        Category(name: "Master Bedroom", weight: 9, photo: nil),
        Category(name: "Master Bathroom", weight: 9, photo: nil),
        Category(name: "Other Bedrooms", weight: 9, photo: nil),
        Category(name: "Backyard", weight: 9, photo: nil),
        Category(name: "Frontyard", weight: 9, photo: nil),
        Category(name: "School District", weight: 9, photo: nil),
        Category(name: "Neighborhood", weight: 9, photo: nil),
        Category(name: "Living Room", weight: 9, photo: nil),
        Category(name: "Basement", weight: 9, photo: nil),
        Category(name: "Other Bathrooms", weight: 9, photo: nil),
        Category(name: "Driveway", weight: 9, photo: nil),
        Category(name: "Laundry Room", weight: 9, photo: nil),
        Category(name: "Garage", weight: 9, photo: nil)
    ]
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
