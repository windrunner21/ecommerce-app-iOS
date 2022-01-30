//
//  ShippingInformation.swift
//  Meowclavas
//
//  Created by Imran on 30.01.22.
//

import Foundation

struct ShippingInformation: Codable {
    var fullName: String
    var address: String
    var city: String
    var zipCode: String
    var subwayStation: String
    var deliveryMethod: String
}
