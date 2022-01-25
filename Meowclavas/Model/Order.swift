//
//  Order.swift
//  Meowclavas
//
//  Created by Imran on 24.01.22.
//

import Foundation

struct Order: Identifiable {
    // identifiable same as product id
    var id: String? {
        product.id! + size.rawValue + puffyColor.rawValue + sizeInSmStr != "0" ? sizeInSmStr : ""
    }
    
    // properties
    var product: Product
    var size: Size = .adult
    var puffyColor: PuffyColorsEnum = .P6
    
    // optional properties
    var sizeInSm: Int?
    var sizeInSmStr: String {
        String(sizeInSm ?? 0)
    }
}
