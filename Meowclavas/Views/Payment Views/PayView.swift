//
//  PayView.swift
//  Meowclavas
//
//  Created by Imran on 27.12.21.
//

import SwiftUI

struct PayView: View {
    @Binding var step3Active: Bool
    @State private var exactCashAmount: Bool = true
    
    var body: some View {
        VStack {
            Text("Currently we support only cash payment. Don't worry, online payment is coming soon!")
                .font(.caption)
            
            Spacer()
            
            CashOptionView(checked: $exactCashAmount)
            
             Spacer()
            
            // Continue button
            Button(action: {
                step3Active.toggle()
            }) {
                Text("Order")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(.primary)
            .cornerRadius(24)
            .padding([.vertical], 20)
        }
        .padding()
    }
}

struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(step3Active: .constant(false))
    }
}
