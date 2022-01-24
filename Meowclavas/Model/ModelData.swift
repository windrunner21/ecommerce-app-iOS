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

final class ModelData: ObservableObject {
    @Published var products = [Product]()
    @Published var promoCodes = [PromoCode]()
    @Published var orders = [Order]()
    
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
}
