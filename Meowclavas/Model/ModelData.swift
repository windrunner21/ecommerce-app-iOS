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
    
    func fetchFromFirestore() {
        Firestore.firestore().collection("products").addSnapshotListener { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("Empty collection")
                    return
                }

                self.products = documents.compactMap { (queryDocumentSnapshot) -> Product? in
                    return try? queryDocumentSnapshot.data(as: Product.self)
                }
            }
        }
    }
}
