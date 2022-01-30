//
//  OrdersView.swift
//  Meowclavas
//
//  Created by Imran on 30.01.22.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            if modelData.history.isEmpty {
                Text("Your order history is currently empty. Better start shopping! 😉")
                    .padding(.vertical)
            } else {
                List {
                    ForEach(modelData.history, id: \.self) { order in
                        Section {
                            Text("Ordered items: ")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            ForEach(order.orderedItems, id: \.self) { item in
                                HStack {
                                    modelData.products.first(where: {$0.id! == item.productID})!.image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(10)

                                    VStack(alignment: .leading) {
                                        Text(modelData.products.first(where: {$0.id! == item.productID})!.name)
                                            .font(.title3)
                                            .bold()
                                        
                                        HStack(alignment: .center) {
                                            Text("Size: \(item.size!.rawValue)")
                                            Divider()
                                            HStack {
                                                Text("Color:")
                                                Image(item.puffyColor!.rawValue)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 15, height: 15)
                                                .clipShape(Circle())
                                            }
                                        }
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(height: 25)
                                        
                                        Text("Quantity: \(item.occurences!)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                    }
                                    
                                    Spacer()
                                }
                            }
                                     
                            Text("Shipment details:")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            HStack {
                                Image(systemName: "shippingbox.fill")
                                Text("\(order.address), \(order.city) - \(order.deliveryOption) Delivery")
                            }
                            .padding()
                            
                            HStack {
                                Image(systemName: "phone.fill")
                                Text(order.phoneNumber)
                            }
                            .padding()
                            
                            HStack {
                                Image(systemName: "creditcard.fill")
                                Text("₼ \(String(format: "%.2f", order.finalPrice))")
                            }
                            .padding()
                        }
                    }
                }
            }

        }
        .navigationTitle("Orders History")
        .onAppear() {
        modelData.fetchHistory()
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
