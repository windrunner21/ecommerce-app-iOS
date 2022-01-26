//
//  Order.swift
//  Meowclavas
//
//  Created by Imran on 24.01.22.
//

import Foundation

struct Order: Identifiable, Codable, Hashable {
    // identifiable create custom articul
    var id: String? {
        var articul = String()
        
        if let ID = productID {
            articul = ID
        }
        
        if let COLOR = puffyColor?.rawValue {
            articul += COLOR
        }
        
        if let SIZE = size?.rawValue {
            articul += SIZE
        }
        
        if let SIZESM = sizeInSm {
            if SIZESM != 0 {
                articul += String(SIZESM)
            }
        }
        
        return articul
    }
    
    // properties
    var productID: String?
    var size: Size?
    var puffyColor: PuffyColorsEnum?
    var sizeInSm: Int?
    var occurences: Int?
}
