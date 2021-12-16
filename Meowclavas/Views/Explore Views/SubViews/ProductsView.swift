//
//  ProductsView.swift
//  Meowclavas
//
//  Created by Imran on 14.12.21.
//

import SwiftUI

struct ProductsView: View {
    @State private var showingFavorites: Bool = false
    @State private var showingBasket: Bool = false
    @State private var showingProduct: Bool = false
    
    var categoryName: String
    var items: [Product]
    var headlineText: String {
        if items.count == 1 {
            return String(items.count) + " item found"
        } else {
            return String(items.count) + " items found"
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            // collection of items and filtering options
            HStack {
                Text(headlineText)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    print("filter clicked")
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.primary)
                        .opacity(0.7)
                }
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(items, id: \.self) { product in
                        CategoryItemView(product: product, leadingPadding: 0)
                            .padding(.vertical)
                            .onTapGesture {
                                showingProduct.toggle()
                            }
                            .sheet(isPresented: $showingProduct) {
                                ProductDetailView(product: product)
                            }
                    }
                }
                
            }
        }
        .padding(.horizontal)
        .navigationTitle(categoryName)
        .toolbar {
            HStack {
                Button {
                    showingFavorites.toggle()
                } label: {
                    Label("Favorites", systemImage: "heart")
                        .foregroundColor(.primary)
                }
                
                Button {
                    showingBasket.toggle()
                } label: {
                    Label("Shoping Bag", systemImage: "bag.fill")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var products = ModelData().products
    
    static var previews: some View {
        ProductsView(
            categoryName: "Designer Collection",
            items: Array(products.prefix(3))
        )
    }
}
