//
//  Product.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Product: Identifiable, Hashable, Codable {
    // identifiable
    @DocumentID var id: String?
    
    // properties
    var name: String
    var price: Double
    var category: Category
    var isFeatured: Bool
    
    // private string for image
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    // optional properties
    var saleInPercents: Int?
    var nonSalePrice: Double? {
        if let sale = saleInPercents, saleInPercents != nil {
            return price * 100 / Double((100 - sale))
        }  else {
            return nil
        }
    }
    
    var description: String?
    var isFavorite: Bool?
    
    var featuredImage: Image? {
        isFeatured ? Image(imageName + "_featured") : nil
    }
}
