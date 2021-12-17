//
//  FavoritesView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode
    var favoriteProducts: [Product]
    
    var body: some View {
        NavigationView {
            VStack {
                List(favoriteProducts) { product in
                    HStack {
                        product.image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.title3)
                                .bold()
                            
                            Text("₼ " + String(format: "%.2f", product.price))
                                
                            
                            Spacer()
                            
                            HStack {
                                Text("Size: M")
                                Divider()
                                Text("Color: gray")
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(height: 25)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("moved")
                        }) {
                            Image(systemName: "bag.badge.plus")
                                .foregroundColor(.primary)
                        }
                        
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Wishlist")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.primary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favoriteProducts: ModelData().products)
    }
}
