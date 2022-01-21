//
//  Favorites.swift
//  Meowclavas
//
//  Created by Imran on 21.01.22.
//

import SwiftUI
import Firebase

class Favorites: ObservableObject {
    // products that user has favorited
    private var products: Set<String>
    
    // key to write/read from UserDefaults
    private let saveKey: String = "Favorites"
    
    // load saved data
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let productsDecoded = try decoder.decode(Set<String>.self, from: data)
                self.products = productsDecoded
                return
            } catch {
                print("Unable to Decode Favorite Products: (\(error))")
            }
        }
        
        self.products = []
    }
    
    // check if set contains products
    func contains(this product: Product) -> Bool {
        products.contains(product.id!)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(this product: Product) {
        objectWillChange.send()
        products.insert(product.id!)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(this product: Product) {
        objectWillChange.send()
        products.remove(product.id!)
        save()
    }
    
    // write favorites data
    func save() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Products
            let data = try encoder.encode(products)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: saveKey)

        } catch {
            print("Unable to Encode Array of Favorite Products: (\(error))")
        }
    }
    
    // load favorites data
    func load() -> Set<String> {
        products
    }
}
