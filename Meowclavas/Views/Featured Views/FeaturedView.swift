//
//  FeaturedView.swift
//  Meowclavas
//
//  Created by Imran on 11.12.21.
//

import SwiftUI

struct FeaturedView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingFavorites: Bool = false
    @State private var showingBasket: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.featured.map { FeaturedCardView(product: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryView(categoryName: key, items: modelData.categories[key]!
                    )
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
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
                FavoritesView()
            }
            .sheet(isPresented: $showingBasket) {
                BasketView()
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
