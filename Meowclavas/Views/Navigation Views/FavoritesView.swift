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
    @EnvironmentObject var baggies: Baggies
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

                            }) {
                                Image(systemName: false ? "bag.badge.minus" : "bag.badge.plus")
                                    .foregroundColor(.primary)
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favoriteProducts: ModelData().products)
    }
}
