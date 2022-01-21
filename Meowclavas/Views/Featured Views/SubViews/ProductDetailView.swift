//
//  ProductDetailView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var favorites: Favorites
    var product: Product
    
    var body: some View {
        ScrollView {
            VStack {
                // product image ignoring safe area and clipped to fill
                product.image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: UIScreen.main.bounds.size.width,
                        height: UIScreen.main.bounds.size.height / 2.5
                    )
                    .clipped()
                
                // product name and price (sale included)
                HStack(alignment: .bottom) {
                    Text(product.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    
                    if product.saleInPercents != nil {
                        VStack(alignment: .trailing) {
                            Text("₼ " + String(format: "%.2f", product.nonSalePrice!))
                                .font(.headline)
                                .bold()
                                .foregroundColor(.gray)
                                .strikethrough()
                            
                            Text("₼ " + String(format: "%.2f", product.price))
                                .font(.title3)
                                .bold()
                        }
                    } else {
                        Text("₼ " + String(format: "%.2f", product.price))
                            .font(.title3)
                            .bold()
                    }
                }
                .padding(.horizontal)
                
                // Color Selection Custom UI
                HStack {
                    Text("Color")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                ColorPickerView()
                
                // Size Selection Custom UI
                HStack {
                    Text("Size")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                SizePickerView()
                
                if let description = product.description,
                    product.description != nil {
                    Text(description)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .padding()
                }
                
                Divider()
                    .padding(.horizontal)
                
                // Buttons
                HStack {
                    // Add to basket button
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add to Bag")
                                .fontWeight(.semibold)
                            
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black)
                    .cornerRadius(24)
                    
                    // Favorites button
                    Image(systemName: "heart.fill")
                        .foregroundColor(favorites.contains(this: product) ? .red : .white)
                        .padding(17)
                        .background(.gray)
                        .clipShape(Circle())
                        .onTapGesture {
                            if favorites.contains(this: product) {
                                favorites.remove(this: product)
                            } else {
                                favorites.add(this: product)
                            }
                        }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: ModelData().products[0])
    }
}
