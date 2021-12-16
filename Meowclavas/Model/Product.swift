//
//  Product.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import Foundation
import SwiftUI

struct Product: Identifiable, Hashable, Codable {
    // identifiable
    var id: Int
    
    // properties
    var name: String
    var price: Double
    var colors: [String]
    var category: Category
    var saleInPercents: Int?
    var nonSalePrice: Double? {
        guard saleInPercents != nil else { return nil }
        return price * 100 / Double((100 - saleInPercents!))
    }
    var size: Size?
    var description: String?
    var isFavorite: Bool?
    var isFeatured: Bool
    
    // private string for image
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var featuredImage: Image? {
        isFeatured ? Image(imageName + "_featured") : nil
    }
}
