//
//  FeaturedView.swift
//  Meowclavas
//
//  Created by Imran on 11.12.21.
//

import SwiftUI

struct FeaturedView: View {
    @EnvironmentObject var baggies: Baggies
    @EnvironmentObject var favorites: Favorites
    @EnvironmentObject var modelData: ModelData
    @State private var showingFavorites: Bool = false
    @State private var showingBasket: Bool = false
    
    var body: some View {
        NavigationView {
            if !modelData.products.isEmpty {
                List {
                    if !modelData.products.isEmpty {
                        PageView(pages: modelData.featured.map { FeaturedCardView(product: $0) })
                            .aspectRatio(3 / 2, contentMode: .fit)
                            .listRowInsets(EdgeInsets())
                    }
                    
                    ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                        CategoryView(categoryName: NSLocalizedString(key, comment: ""), items: modelData.categories[key]!
                        )
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.inset)
                .navigationTitle("Featured")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    HStack {
                        Button {
                            showingFavorites.toggle()
                        } label: {
                            Label("Favorites", systemImage: "heart")
                                .foregroundColor(favorites.load().isEmpty ? .primary : .blue)
                        }
                        
                        Button {
                            showingBasket.toggle()
                        } label: {
                            Label("Shoping Bag", systemImage: "bag.fill")
                                .foregroundColor(baggies.load().isEmpty ? .primary : .blue)
                        }
                    }
                }
                .sheet(isPresented: $showingFavorites) {
                    FavoritesView(favoriteProducts: modelData.products.filter { favorites.load().contains($0.id!) })
                }
                .sheet(isPresented: $showingBasket) {
                    BasketView()
                }
            } else {
                ProgressView()
                    .navigationTitle("Featured")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        HStack {
                            Button {
                                showingFavorites.toggle()
                            } label: {
                                Label("Favorites", systemImage: "heart")
                                    .foregroundColor(favorites.load().isEmpty ? .primary : .blue)
                            }
                            
                            Button {
                                showingBasket.toggle()
                            } label: {
                                Label("Shoping Bag", systemImage: "bag.fill")
                                    .foregroundColor(baggies.load().isEmpty ? .primary : .blue)
                            }
                        }
                    }
                    .sheet(isPresented: $showingFavorites) {
                        FavoritesView(favoriteProducts: modelData.products.filter { favorites.load().contains($0.id!) })
                    }
                    .sheet(isPresented: $showingBasket) {
                        BasketView()
                    }
            }
        }
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
            .environmentObject(ModelData())
    }
}
