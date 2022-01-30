//
//  ShippingView.swift
//  Meowclavas
//
//  Created by Imran on 26.12.21.
//

import SwiftUI

struct ShippingView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var shipment: Shipping
    
    @Binding var step2Active: Bool
    @State private var phoneNumber: String = String()
    @State private var showPhoneNumberError: Bool = false
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
                    TextField("Phone Number", text: $phoneNumber, onCommit: {
                        if !phoneNumber.isEmpty {
                            addressIsFocused = true
                        }
                    })
                        .font(.system(size: 19, weight: .semibold))
                        .keyboardType(.numberPad)
                    
                    if showPhoneNumberError {
                        Text("Phone number cannot be empty.")
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
                    handleShippingInformation()
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
            .padding(.horizontal)
        }
        .onAppear() {
            let loadedInfo = shipment.load()

            phoneNumber = loadedInfo.phoneNumber
            address = loadedInfo.address
            zipCode = loadedInfo.zipCode
            city = loadedInfo.city
            subwayStation = loadedInfo.subwayStation
            
            if loadedInfo.deliveryMethod == "Subway" {
                toSubwayDelivery = true
                toAddressDelivery = false
            } else {
                toSubwayDelivery = false
                toAddressDelivery = true
            }
        }
    }
    
    func handleShippingInformation() {
        if phoneNumber.isEmpty {
            showPhoneNumberError = true
        } else {
            showPhoneNumberError = false
        }
        
        if address.isEmpty {
            showAddressError = true
        } else {
            showAddressError = false
        }
        
        if city.isEmpty {
            showCityError = true
        } else {
            showCityError = false
        }
        
        if zipCode.isEmpty {
            showZipCodeError = true
        } else {
            showZipCodeError = false
        }
        
        if subwayStation.isEmpty {
            showSubwayStationError = true
        } else {
            showSubwayStationError = false
        }
        
        if !phoneNumber.isEmpty && !address.isEmpty && !city.isEmpty && !zipCode.isEmpty && !subwayStation.isEmpty {
            
            let info = ShippingInformation(phoneNumber: phoneNumber, address: address, city: city, zipCode: zipCode, subwayStation: subwayStation, deliveryMethod: toSubwayDelivery ? "Subway" : "Address")
            
            shipment.write(info)
            
            modelData.userOrder.phoneNumber = info.phoneNumber
            modelData.userOrder.address = info.address
            modelData.userOrder.city = info.city
            modelData.userOrder.zipCode = info.zipCode
            modelData.userOrder.subwayStation = info.subwayStation
            modelData.userOrder.deliveryOption = info.deliveryMethod
            
            if toAddressDelivery {
                modelData.userOrder.finalPrice += 10
            }
            
            step2Active.toggle()
        }
    }
}

struct ShippingView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingView(step2Active: .constant(false))
    }
}
