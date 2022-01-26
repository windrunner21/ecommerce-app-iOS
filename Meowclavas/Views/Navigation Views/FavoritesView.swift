//
//  FavoritesView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI


// TODO: what if favorites are empty
struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favorites: Favorites
    @State var favoriteProducts: [Product]
    
    var body: some View {
        NavigationView {
            if favorites.load().isEmpty {
                VStack {
                    Spacer()
                    LottieView(name: "wishlist-empty", loopMode: .loop)
                        .frame(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.height / 4)
                    Text("Hmm! Can't find anything in your wishlist.")
                    Spacer()
                }
                .navigationTitle("Wishlist")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Continue Shopping") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.primary)
                    }
                }
            } else {
                List {
                    ForEach(favoriteProducts, id: \.self) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            HStack {
                                product.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.title3)
                                        .bold()
                                    
                                    Text("₼ " + String(format: "%.2f", product.price))
                                        
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .onDelete() {
                        favorites.remove(this: favoriteProducts[$0.first!])
                        favoriteProducts.remove(atOffsets: $0)
                    }
                    .padding(.vertical)
                }
                .navigationTitle("Wishlist")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back") {
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
}
