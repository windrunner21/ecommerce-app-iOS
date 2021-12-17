//
//  ExploreView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingFavorites: Bool = false
    @State private var showingBasket: Bool = false
    @State private var searchText: String = String()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    NavigationLink(
                        destination: ProductsView(categoryName: key, items: modelData.categories[key]!)
                    ) {
                        ExploreItemView(categoryName: key)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .searchable(text: $searchText)
            .listStyle(.inset)
            .navigationTitle("Explore")
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
            .sheet(isPresented: $showingFavorites) {
                FavoritesView(favoriteProducts: modelData.products)
            }
            .sheet(isPresented: $showingBasket) {
                BasketView(bagProducts: modelData.products)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environmentObject(ModelData())
    }
}
