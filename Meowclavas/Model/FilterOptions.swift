//
//  FilterOptions.swift
//  Meowclavas
//
//  Created by Imran on 27.01.22.
//

import Foundation

struct FilterOptions: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var isSelected: Bool
}
