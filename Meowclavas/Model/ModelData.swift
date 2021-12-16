//
//  ModelData.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var products: [Product] = load("productData.json")
    
    // only featured products
    var featured: [Product] {
        products.filter { $0.isFeatured }
    }
    
    // products taken into dictionary by category values
    var categories: [String: [Product]] {
        Dictionary(
            grouping: products,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
