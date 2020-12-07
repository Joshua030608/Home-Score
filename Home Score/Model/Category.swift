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
    
    
    static let categoryNames = [
        "Kitchen",
        "Master Bedroom",
        "Master Bathroom",
        "Other Bedrooms",
        "Backyard",
        "Frontyard",
        "School District",
        "Neighborhood",
        "Living Room",
        "Basement",
        "Master Bathrooms",
        "Other Bathrooms",
        "Driveway",
        "Laundry Room",
        "Garage"
    ]
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
