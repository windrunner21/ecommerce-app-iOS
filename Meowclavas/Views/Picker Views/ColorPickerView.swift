//
//  ColorPickerView.swift
//  Meowclavas
//
//  Created by Imran on 17.12.21.
//

import SwiftUI

struct ColorPickerView: View {
    @EnvironmentObject var modelData: ModelData
    var product: Product
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack(spacing: 25) {
                    ForEach(PuffyColorsEnum.allCases, id: \.self) { color in
                        if color == modelData.orders.first(where: {$0.product.id! == product.id!})?.puffyColor {
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
                                    guard let currentOrderIndex = modelData.orders.firstIndex(where: {$0.product.id! == product.id!}) else {return}
                                    guard var currentOrder = modelData.orders.first(where: {$0.product.id! == product.id!}) else { return }
                                    currentOrder.puffyColor = color
                                    
                                    modelData.orders[currentOrderIndex] = currentOrder
                                }
                        }
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
                .onAppear() {
                    switch modelData.orders.first(where: {$0.product.id! == product.id!})?.puffyColor {
                    case .P60: scrollView.scrollTo(PuffyColorsEnum.P60, anchor: .bottom)
                    case .P87: scrollView.scrollTo(PuffyColorsEnum.P87, anchor: .bottom)
                    case .P106: scrollView.scrollTo(PuffyColorsEnum.P106, anchor: .bottom)
                    case .P141: scrollView.scrollTo(PuffyColorsEnum.P141, anchor: .bottom)
                    case .P179: scrollView.scrollTo(PuffyColorsEnum.P179, anchor: .bottom)
                    case .P185: scrollView.scrollTo(PuffyColorsEnum.P185, anchor: .bottom)
                    case .P312: scrollView.scrollTo(PuffyColorsEnum.P312, anchor: .bottom)
                    case .P485: scrollView.scrollTo(PuffyColorsEnum.P485, anchor: .bottom)
                    case .P490: scrollView.scrollTo(PuffyColorsEnum.P490, anchor: .bottom)
                    case .P686: scrollView.scrollTo(PuffyColorsEnum.P686, anchor: .bottom)
                    case .P717: scrollView.scrollTo(PuffyColorsEnum.P717, anchor: .bottom)
                    case .P735: scrollView.scrollTo(PuffyColorsEnum.P735, anchor: .bottom)
                    case .PC5925: scrollView.scrollTo(PuffyColorsEnum.PC5925, anchor: .bottom)
                    case .PC6257: scrollView.scrollTo(PuffyColorsEnum.PC6257, anchor: .bottom)
                    case .PC6371: scrollView.scrollTo(PuffyColorsEnum.PC6371, anchor: .bottom)
                    case .PC6376: scrollView.scrollTo(PuffyColorsEnum.PC6376, anchor: .bottom)
                    case .PC6377: scrollView.scrollTo(PuffyColorsEnum.PC6377, anchor: .bottom)
                    case .PC6383: scrollView.scrollTo(PuffyColorsEnum.PC6383, anchor: .bottom)
                    case .PC6395: scrollView.scrollTo(PuffyColorsEnum.PC6395, anchor: .bottom)
                    case .PC6398: scrollView.scrollTo(PuffyColorsEnum.PC6398, anchor: .bottom)
                    case .PC6430: scrollView.scrollTo(PuffyColorsEnum.PC6430, anchor: .bottom)
                    case .PC6500: scrollView.scrollTo(PuffyColorsEnum.PC6500, anchor: .bottom)
                    default: break
                    }
                }
            }
        }
    }
}
