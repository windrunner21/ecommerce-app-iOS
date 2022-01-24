//
//  CashOptionView.swift
//  Meowclavas
//
//  Created by Imran on 30.12.21.
//

import SwiftUI

struct CashOptionView: View {
    @Binding var checked: Bool
    @State private var amount: String = String()
    @FocusState private var isFocused: Bool
    
    var returnAmount: Double {
        (Double(amount) ?? 0) - 20.0
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
        
                        TextField("amount", text: $amount)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        
                        Button(action: {
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
