//
//  SizeEnum.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import Foundation

enum Size: String, CaseIterable, Codable {
    case baby = "Baby"
    case kid = "Kid"
    case adult = "Adult"
    case adultPlus = "Adult XL"
    case custom = "Custom"
}
