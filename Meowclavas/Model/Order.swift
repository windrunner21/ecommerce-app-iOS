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
        product.id
    }
    
    // properties
    var product: Product
    var size: Size = .adult
    
    // optional properties
    var sizeInSm: Int?
    var color: Colors?
    var promoCode: PromoCode?
}
