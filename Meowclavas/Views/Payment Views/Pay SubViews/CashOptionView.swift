//
//  CashOptionView.swift
//  Meowclavas
//
//  Created by Imran on 30.12.21.
//

import SwiftUI

struct CashOptionView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var checked: Bool
    @State private var amount: Double = 0.0
    @FocusState private var isFocused: Bool
    
    var returnAmount: Double {
        if amount < modelData.userOrder.finalPrice.rounded() {
            return 0
        } else {
            return amount - modelData.userOrder.finalPrice.rounded()
        }
    }
    
    
    var body: some View {
        VStack(spacing: 10.0) {
            HStack {
                Image(systemName: checked ?
                      "checkmark.square.fill" : "checkmark.square")
                    .font(.system(size: 24))
                    .foregroundColor(checked ?
                                        .green : .primary)
                
                Text("I have exact cash amount")
                    .foregroundColor(checked ?
                                        .primary : Color(UIColor.systemGray2))
                    .font(.system(size: 19, weight: .semibold))
                Spacer()
            }
            .onTapGesture {
                checked.toggle()
            }
            
            HStack {
                Image(systemName: !checked ?
                      "checkmark.square.fill" : "checkmark.square")
                    .font(.system(size: 24))
                    .foregroundColor(!checked ?
                                        .green : .primary)
                
                Text("I'll require change")
                    .foregroundColor(!checked ?
                                        .primary : Color(UIColor.systemGray2))
                    .font(.system(size: 19, weight: .semibold))
                Spacer()
            }
            .onTapGesture {
                checked.toggle()
            }
            
            if !checked {
                VStack {
                    HStack {
                        Text("I have ₼ ")
        
                        TextField("amount", value: $amount, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .onAppear() {
                                amount = modelData.userOrder.finalPrice
                            }
                        
                        Button(action: {
                            if amount < modelData.userOrder.finalPrice {
                                amount = modelData.userOrder.finalPrice
                            }
                            
                            modelData.userOrder.changeRequired = returnAmount
                            isFocused = false
                        }) {
                            Text("OK")
                                .foregroundColor(Color(UIColor.systemBackground))
                                .padding(4)
                        }
                        .padding(.horizontal)
                        .background(.primary)
                        .cornerRadius(10)
                    }
                    
                    HStack {
                        Text("Courier will return ₼ \(String(format: "%.2f", returnAmount))")
                        Spacer()
                    }
                }
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(10)
            }
        }
    }
}

struct CashOptionView_Previews: PreviewProvider {
    static var previews: some View {
        CashOptionView(checked: .constant(false))
    }
}
