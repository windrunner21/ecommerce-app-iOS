//
//  PromoCode.swift
//  Meowclavas
//
//  Created by Imran on 23.01.22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct PromoCode: Identifiable, Hashable, Codable {
    // identifiable
    @DocumentID var id: String?
    
    // properties
    var code: String
    var off: Int
}
