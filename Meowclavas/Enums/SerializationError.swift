//
//  SerializationError.swift
//  Meowclavas
//
//  Created by Imran on 18.01.22.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}
