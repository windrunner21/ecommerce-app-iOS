//
//  Filter.swift
//  Meowclavas
//
//  Created by Imran on 27.01.22.
//

import Foundation

struct Filter: Equatable {
    var minPrice: Double
    var maxPrice: Double
    var options: Set<String>
}
