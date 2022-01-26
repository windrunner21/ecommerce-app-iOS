//
//  ColorPickerView.swift
//  Meowclavas
//
//  Created by Imran on 17.12.21.
//

import SwiftUI

struct ColorPickerView: View {
    var product: Product
    @Binding var colorSelected: PuffyColorsEnum?
    @Binding var currentOrderToSet: Order
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack(spacing: 25) {
                    ForEach(PuffyColorsEnum.allCases, id: \.self) { color in
                        if color == colorSelected {
                            Image(color.rawValue)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 4)
                                }
                                .shadow(radius: 3)
                        } else {
                            Image(color.rawValue)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                                .onTapGesture {
                                    colorSelected = color
                                    currentOrderToSet.puffyColor = colorSelected
                                }
                        }
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
            }
        }
    }
}
