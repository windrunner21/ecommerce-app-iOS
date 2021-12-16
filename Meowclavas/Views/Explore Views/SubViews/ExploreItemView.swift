//
//  ExploreItemView.swift
//  Meowclavas
//
//  Created by Imran on 14.12.21.
//

import SwiftUI

struct ExploreItemView: View {
    var categoryName: String
    
    // computed property depending on category name
    var categoryCallout: String {
        switch categoryName {
        case "Designer Collection":
            return "Be unique. Be yourself."
        case "Hot Sale":
            return "Up to 50% off."
        default:
            return "Browse balaclavas collection."
        }
    }
    
    var body: some View {
        ZStack {
            Image(categoryName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                .clipped()
            
            VStack(spacing: 10.0) {
                Text(categoryName)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text(categoryCallout)
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    

            }
            .padding(.horizontal)
        }
    }
}

struct ExploreItemView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreItemView(categoryName: "Designer Collection")
    }
}
