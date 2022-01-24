//
//  SizePickerView.swift
//  Meowclavas
//
//  Created by Imran on 17.12.21.
//

import SwiftUI

struct SizePickerView: View {
    @EnvironmentObject var modelData: ModelData
    var product: Product
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack(spacing: 25) {
                    ForEach(Size.allCases, id: \.self) { size in
                        if size == modelData.orders.first(where: {$0.id == product.id!})?.size {
                            Text(size.rawValue)
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
                            Text(size.rawValue)
                                .bold()
                                .foregroundColor(.gray)
                                .textCase(.uppercase)
                            
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .background(Color(UIColor.systemGray5))
                                .clipShape(Capsule())
                                .onTapGesture {
                                    guard let currentOrderIndex = modelData.orders.firstIndex(where: {$0.id == product.id!}) else {return}
                                    guard var currentOrder = modelData.orders.first(where: {$0.id == product.id!}) else { return }
                                    currentOrder.size = size
                                    
                                    modelData.orders[currentOrderIndex] = currentOrder
                                }
                        }
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
                .onAppear() {
                    if modelData.orders.first(where: {$0.id == product.id!})?.size == .custom {
                        scrollView.scrollTo(Size.custom)
                    }
                    
                    if modelData.orders.first(where: {$0.id == product.id!})?.size == .adultPlus {
                        scrollView.scrollTo(Size.adultPlus)
                    }
                }
            }
        }
    }
}
