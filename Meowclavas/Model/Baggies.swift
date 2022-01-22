//
//  BasketProducts.swift
//  Meowclavas
//
//  Created by Imran on 22.01.22.
//

import SwiftUI

class Baggies: ObservableObject {
    // products that user added to shopping cart
    private var products: Set<String>
    
    // key to write/read from UserDeaults
    private let saveKey: String = "Baggies"
    
    // load saved data
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode product
                let productsDecoded = try decoder.decode(Set<String>.self, from: data)
                self.products = productsDecoded
                return
            } catch {
                print("Unable to Decode Baggies: (\(error))")
            }
        }
        
        self.products = []
    }
    
    // check if set contains products
    func contains(this product: Product) -> Bool {
        products.contains(product.id!)
    }
    
    // adds the product to our set, updates all views, and saves the change
    func add(this product: Product) {
        objectWillChange.send()
        products.insert(product.id!)
        save()
    }
    
    // removes the product from our set, updates all views, and saves the change
    func remove(this product: Product) {
        objectWillChange.send()
        products.remove(product.id!)
        save()
    }
    
    // write baggies data
    func save() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Products
            let data = try encoder.encode(products)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: saveKey)

        } catch {
            print("Unable to Encode Array of Baggies: (\(error))")
        }
    }
    
    func load() -> Set<String> {
        products
    }
}
