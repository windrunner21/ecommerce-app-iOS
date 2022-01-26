//
//  BasketProducts.swift
//  Meowclavas
//
//  Created by Imran on 22.01.22.
//

import SwiftUI

class Baggies: ObservableObject {
    // products that user added to shopping cart
    private var products: [Order]
    
    // key to write/read from UserDeaults
    private let saveKey: String = "Baggies"
    
    // load saved data
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode product
                let productsDecoded = try decoder.decode([Order].self, from: data)
                self.products = productsDecoded
                return
            } catch {
                print("Unable to Decode Baggies: (\(error))")
            }
        }
        
        self.products = []
    }
    
    // check if set contains products
    func contains(this order: Order) -> Bool {
        for ord in products {
            if ord.productID == order.productID
                && ord.puffyColor == order.puffyColor
                && ord.size == order.size
                && ord.sizeInSm == order.sizeInSm {
                return true
            }
        }
        return false
    }
    
    // adds the product to our set, updates all views, and saves the change
    func add(this order: Order) {
        objectWillChange.send()
        
        if let orderFoundIndex = products.firstIndex(of: order) {
            let tempOrder = Order(productID: order.productID, size: order.size, puffyColor: order.puffyColor, sizeInSm: order.sizeInSm, occurences: (order.occurences! + 1))
            products[orderFoundIndex] = tempOrder
        } else {
            products.append(order)
        }
        
        save()
    }
    
    // removes the product from our set, updates all views, and saves the change
    func remove(this order: Order) {
        objectWillChange.send()
        
        if let orderFoundIndex = products.firstIndex(of: order) {
            if order.occurences! <= 1 {
                products.remove(at: orderFoundIndex)
            } else {
                let tempOrder = Order(productID: order.productID, size: order.size, puffyColor: order.puffyColor, sizeInSm: order.sizeInSm, occurences: (order.occurences! - 1))
                products[orderFoundIndex] = tempOrder

            }
        }
        
        save()
    }
    
    // remove element completely
    func removeCompletely(this order: Order) {
        objectWillChange.send()
        
        if let orderFoundIndex = products.firstIndex(of: order) {
            products.remove(at: orderFoundIndex)
        }
        
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
    
    func load() -> [Order] {
        products
    }
}
