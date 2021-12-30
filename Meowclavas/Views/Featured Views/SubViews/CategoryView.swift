//
//  CategoryView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct CategoryView: View {
    var categoryName: String
    var items: [Product]
    @State private var productDetailed: Product? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding(.leading, 15)
                .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0.0) {
                    ForEach(items) { product in
                        CategoryItemView(product: product, leadingPadding: 15)
                            .onTapGesture {
                                productDetailed = product
                            }
                    }
                    .sheet(item: $productDetailed) { product in
                        ProductDetailView(product: product)
                    }
                }
            }
            .frame(height: 200)
        }
        .padding(.bottom, 15)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var products = ModelData().products
    
    static var previews: some View {
        CategoryView(
            categoryName: products[0].category.rawValue,
            items: Array(products.prefix(3))
        )
    }
}
