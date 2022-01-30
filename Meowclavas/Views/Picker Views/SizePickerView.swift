//
//  SizePickerView.swift
//  Meowclavas
//
//  Created by Imran on 17.12.21.
//

import SwiftUI

struct SizePickerView: View {
    var product: Product
    @Binding var sizeSelected: Size?
    @Binding var currentOrderToSet: Order
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack(spacing: 25) {
                    ForEach(Size.allCases, id: \.self) { size in
                        if size == sizeSelected {
                            Text(NSLocalizedString(size.rawValue, comment: ""))
                                .bold()
                                .foregroundColor(.gray)
                                .textCase(.uppercase)
                            
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .background(Color(UIColor.systemGray5))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().stroke(.white, lineWidth: 4)
                                )
                                .shadow(radius: 3)
                        } else {
                            Text(NSLocalizedString(size.rawValue, comment: ""))
                                .bold()
                                .foregroundColor(.gray)
                                .textCase(.uppercase)
                            
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .background(Color(UIColor.systemGray5))
                                .clipShape(Capsule())
                                .onTapGesture {
                                    sizeSelected = size
                                    currentOrderToSet.size = sizeSelected
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
