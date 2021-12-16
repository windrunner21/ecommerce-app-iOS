//
//  CategoryEnum.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case onSale = "Hot Sale"
    case unique = "Designer Collection"
    case popular = "Top Trends"
    case regular = "Regular"
}
