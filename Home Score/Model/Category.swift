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
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
