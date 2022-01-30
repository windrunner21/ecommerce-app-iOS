//
//  UserOrder.swift
//  Meowclavas
//
//  Created by Imran on 28.01.22.
//

import Foundation

struct UserOrder: Codable {
    var orderedItems: [Order]
    
    // price variables
    var promoCode: String?
    var finalPrice: Double
    
    // shipping variables
    var fullName: String
    var address: String
    var city: String
    var zipCode: String
    var subwayStation: String
    var deliveryOption: String
    
    // payment option variables
    var paymentOption: String
    var changeRequired: Double
}
