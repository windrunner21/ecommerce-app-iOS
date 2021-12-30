//
//  CategoryItemView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct CategoryItemView: View {
    var product: Product
    @State private var isFavorite: Bool = false
    var leadingPadding: CGFloat?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                product.image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                
                Image(systemName: "heart.fill")
                    .foregroundColor(isFavorite ? .red : .gray)
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
                    .padding(5)
                    .onTapGesture {
                        isFavorite.toggle()
                    }
            }
            
            Text(product.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                
            Text("₼ " + String(format: "%.2f", product.price))
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.leading, leadingPadding)
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(
            product: ModelData().products[0],
            leadingPadding: 15
        )
    }
}
