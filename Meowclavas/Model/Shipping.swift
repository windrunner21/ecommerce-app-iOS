//
//  Shipping.swift
//  Meowclavas
//
//  Created by Imran on 30.01.22.
//

import Foundation

class Shipping: ObservableObject {
    // shipping information to save
    private var shippingInfo: ShippingInformation
    
    // key to write/read from UserDeaults
    private let saveKey: String = "ShippingInformation"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode product
                let shippingDecoded = try decoder.decode(ShippingInformation.self, from: data)
                self.shippingInfo = shippingDecoded
                return
            } catch {
                print("Unable to Decode Shipment Info: (\(error))")
            }
        }
        
        self.shippingInfo = ShippingInformation(fullName: "", address: "", city: "", zipCode: "", subwayStation: "", deliveryMethod: "Subway")
    }
    
    // adds the product to our set, updates all views, and saves the change
    func write(_ info: ShippingInformation) {
        objectWillChange.send()
        
        self.shippingInfo = info
        
        save()
    }
    
    func save() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Products
            let data = try encoder.encode(shippingInfo)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: saveKey)

        } catch {
            print("Unable to Encode Shipment Info: (\(error))")
        }
    }
    
    func load() -> ShippingInformation {
        shippingInfo
    }
}
