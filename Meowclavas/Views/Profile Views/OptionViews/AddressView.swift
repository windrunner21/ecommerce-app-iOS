//
//  AddressView.swift
//  Meowclavas
//
//  Created by Imran on 15.12.21.
//

import SwiftUI

struct AddressView: View {
    @EnvironmentObject var shipment: Shipping
    
    var body: some View {
        ScrollView {
            VStack {
                if shipment.load().phoneNumber.isEmpty {
                    Text("Address either missing or incomplete.")
                } else {
                    Group {
                        HStack {
                            Image(systemName: "iphone")
                            Text(shipment.load().phoneNumber)
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "house")
                            Text(shipment.load().address)
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                            Text(shipment.load().city)
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "envelope.circle.fill")
                            Text(shipment.load().zipCode)
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "tram")
                            Text(shipment.load().subwayStation)
                            Spacer()
                        }
                        
                        Divider()
                    }
                }
            }
            .padding()
        .navigationTitle("Your address")
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
            .environmentObject(Shipping())
    }
}
