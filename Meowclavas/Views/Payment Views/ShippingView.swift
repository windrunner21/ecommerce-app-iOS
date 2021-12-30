//
//  ShippingView.swift
//  Meowclavas
//
//  Created by Imran on 26.12.21.
//

import SwiftUI

struct ShippingView: View {
    @Binding var step2Active: Bool
    @State private var fullName: String = String()
    @State private var showFullNameError: Bool = false
    @State private var address: String = String()
    @State private var showAddressError: Bool = false
    @State private var zipCode: String = String()
    @State private var showZipCodeError: Bool = false
    @State private var city: String = String()
    @State private var showCityError: Bool = false
    @State private var subwayStation: String = String()
    @State private var showSubwayStationError: Bool = false
    @FocusState private var addressIsFocused: Bool
    @FocusState private var zipCodeIsFocused: Bool
    @FocusState private var cityIsFocused: Bool
    @FocusState private var subwayStationIsFocused: Bool
    
    @State private var toAddressDelivery: Bool = false
    @State private var toSubwayDelivery: Bool = true
    
    @State private var selectedStation = SubwayStations.elmler
    @State private var selectedCity = Cities.baku
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    TextField("Full Name", text: $fullName, onCommit: {
                        if !fullName.isEmpty {
                            addressIsFocused = true
                        }
                    })
                        .font(.system(size: 19, weight: .semibold))
                    
                    if showFullNameError {
                        Text("Email cannot be empty.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                 
                    Divider()
                    
                    TextField("Address", text: $address, onCommit: {
                        if !address.isEmpty {
                            cityIsFocused = true
                        }
                    })
                        .font(.system(size: 19, weight: .semibold))
                        .focused($addressIsFocused)
                    
                    
                    if showAddressError {
                        Text("Address cannot be empty.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    
                    Divider()
                }
                
                HStack {
                    VStack {
                        TextField("City", text: $city, onCommit: {
                            if !city.isEmpty {
                                zipCodeIsFocused = true
                            }
                        })
                            .font(.system(size: 19, weight: .semibold))
                            .focused($cityIsFocused)
            
                        Divider()
            
                        if showCityError {
                            Text("City cannot be empty.")
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack {
                        TextField("Zip Code", text: $zipCode, onCommit: {
                            if !zipCode.isEmpty {
                                subwayStationIsFocused = true
                            }
                        })
                            .font(.system(size: 19, weight: .semibold))
                            .focused($zipCodeIsFocused)
            
                        Divider()
            
                        if showZipCodeError {
                            Text("Zip Code cannot be empty.")
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                }
                
                TextField("Nearest Subway Station", text: $subwayStation)
                    .font(.system(size: 19, weight: .semibold))
                    .focused($subwayStationIsFocused)

                if showSubwayStationError {
                    Text("Nearest Subway Station cannot be empty.")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                
                Divider()
                
                Text("Shipping Method")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                
                ShippingMethodView(
                    free: true,
                    option: "Subway Delivery",
                    checked: $toSubwayDelivery,
                    alternativeChecked: $toAddressDelivery
                )
                
                ShippingMethodView(
                    free: false,
                    option: "Address Delivery",
                    checked: $toAddressDelivery,
                    alternativeChecked: $toSubwayDelivery
                )
                
                Spacer()
                
                // Continue button
                Button(action: {
                    step2Active.toggle()
                }) {
                    Text("Continue to Payment")
                        .foregroundColor(Color(UIColor.systemBackground))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(.primary)
                .cornerRadius(24)
          
            }
            .padding()
        }
    }
}

struct ShippingView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingView(step2Active: .constant(false))
    }
}
