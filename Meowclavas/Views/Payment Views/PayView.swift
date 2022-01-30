//
//  PayView.swift
//  Meowclavas
//
//  Created by Imran on 27.12.21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct PayView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var step3Active: Bool
    @State private var exactCashAmount: Bool = true
    
    var body: some View {
        VStack {
                        
            HStack {
                Text("Total price for \(modelData.userOrder.orderedItems.count) ordered items is")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            HStack {
                Text("₼ " + String(format: "%.2f" ,modelData.userOrder.finalPrice))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.bottom)
            
            CashOptionView(checked: $exactCashAmount)
            
             Spacer()
            
            Text("❗Currently we support only cash payment. Don't worry, online payment is coming soon!")
                .font(.caption)
                .padding(.bottom)
            
            // Continue button
            Button(action: {
                do {
                    try Firestore.firestore().collection("usersOrders")
                        .document(Auth.auth().currentUser!.uid)
                        .collection("orders")
                        .document()
                        .setData(from: modelData.userOrder)
                    
                    step3Active.toggle()
                } catch let error {
                    print("Error writing city to Firestore: \(error)")
                }
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
