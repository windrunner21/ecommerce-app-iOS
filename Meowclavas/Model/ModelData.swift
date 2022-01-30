//
//  ModelData.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

final class ModelData: ObservableObject {
    @Published var products = [Product]()
    @Published var promoCodes = [PromoCode]()
    @Published var filter = Filter(minPrice: 0, maxPrice: 100, options: [])
    @Published var userOrder = UserOrder(orderedItems: [], finalPrice: 0.0, phoneNumber: "", address: "", city: "", zipCode: "", subwayStation: "", deliveryOption: "", paymentOption: "Cash", changeRequired: 0.0)
    @Published var history = [UserOrder]()
    
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
    
    // apply filter to products
    func filteredProducts(_ products: [Product]) -> [Product] {
        if filter.options.isEmpty {
            return products.filter { $0.price > filter.minPrice && $0.price < filter.maxPrice }
        }
        return products.filter { $0.price > filter.minPrice && $0.price < filter.maxPrice && filter.options.contains($0.name.components(separatedBy: " ")[0])}
    }
    
    // get main products from firestore
    func fetchFromFirestore() {
        Firestore.firestore().collection("products").addSnapshotListener { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents (products): \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("Empty collection (products).")
                    return
                }

                self.products = documents.compactMap { (queryDocumentSnapshot) -> Product? in
                    return try? queryDocumentSnapshot.data(as: Product.self)
                }
            }
        }
    }
    
    // get promo codes from firestore
    func fetchPromoCodes() {
        Firestore.firestore().collection("promoCodes").addSnapshotListener { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents (promo codes): \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("Empty collection (promo codes).")
                    return
                }
                
                self.promoCodes = documents.compactMap { (queryDocumentSnapshot) -> PromoCode? in
                    return try? queryDocumentSnapshot.data(as: PromoCode.self)
                }
            }
        }
    }
    
    func fetchHistory() {
        Firestore.firestore().collection("usersOrders").document(Auth.auth().currentUser!.uid).collection("orders").addSnapshotListener { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents (history): \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("Empty collection (history).")
                    return
                }
                
                self.history = documents.compactMap { (queryDocumentSnapshot) -> UserOrder? in
                    return try? queryDocumentSnapshot.data(as: UserOrder.self)
                }
            }
        }
    }
}
