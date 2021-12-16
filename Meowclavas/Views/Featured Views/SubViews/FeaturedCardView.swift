//
//  FeaturedCardView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

// TODO: bug with featuredImage

struct FeaturedCardView: View {
    var product: Product
    
    var body: some View {
        product.featuredImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(OverlayView(product: product))
    }
}

struct OverlayView: View {
    var product: Product
    
    // darken the background for white text to be visible
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.title)
                    .bold()
                Text("₼ " + String(format: "%.2f", product.price))
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeaturedCardView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCardView(
            product: ModelData().featured[0]
        )
    }
}
