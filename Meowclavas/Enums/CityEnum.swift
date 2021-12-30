//
//  CityEnum.swift
//  Meowclavas
//
//  Created by Imran on 27.12.21.
//

import Foundation

enum Cities: String, CaseIterable, Identifiable {
    case baku = "Baku"
    
    var id: String { self.rawValue }
}
