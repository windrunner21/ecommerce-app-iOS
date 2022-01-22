//
//  BasketProducts.swift
//  Meowclavas
//
//  Created by Imran on 22.01.22.
//

import SwiftUI

class Baggies: ObservableObject {
    // products that user added to shopping cart
    private var products: Dictionary<String, Int>
    
    // key to write/read from UserDeaults
    private let saveKey: String = "Baggies"
    
    // load saved data
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode product
                let productsDecoded = try decoder.decode(Dictionary<String, Int>.self, from: data)
                self.products = productsDecoded
                return
            } catch {
                print("Unable to Decode Baggies: (\(error))")
            }
        }
        
        self.products = [:]
    }
    
    // check if set contains products
    func contains(this product: Product) -> Bool {
        products[product.id!] != nil
    }
    
    // adds the product to our set, updates all views, and saves the change
    func add(this product: Product) {
        objectWillChange.send()
        
        if let productFound = products[product.id!] {
            var quantityToBeUpdated = productFound
            quantityToBeUpdated += 1
            
            products[product.id!] = quantityToBeUpdated
        } else {
            products[product.id!] = 1
        }
        
        save()
    }
    
    // removes the product from our set, updates all views, and saves the change
    func remove(this product: Product) {
        objectWillChange.send()
        
        if let productFound = products[product.id!] {
            var quantityToBeUpdated = productFound
            
            if quantityToBeUpdated <= 1 {
                products[product.id!] = nil
            } else {
                quantityToBeUpdated -= 1
                products[product.id!] = quantityToBeUpdated
            }
        }
        
        save()
    }
    
    // remove element completely
    func removeCompletely(this product: Product) {
        objectWillChange.send()
        products[product.id!] = nil
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
            print("Unable to Encode Dictionary of Baggies: (\(error))")
        }
    }
    
    func load() -> Dictionary<String, Int> {
        products
    }
}
