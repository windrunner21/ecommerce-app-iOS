//
//  ProductDetailView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var baggies: Baggies
    @EnvironmentObject var favorites: Favorites
    
    @State private var colorSelected: PuffyColorsEnum?
    @State private var sizeSelected: Size?
    @State private var headSizeInSm: Int = 0
    @FocusState private var isFocused: Bool
    
    @State private var showColorError: Bool = false
    @State private var showSizeError: Bool = false
    
    @State private var orderToCheck: Order = Order()
    
    var body: some View {
        ScrollView {
            VStack {
                product.image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: UIScreen.main.bounds.size.width,
                        height: UIScreen.main.bounds.size.height / 2.5
                    )
                    .clipped()
                    .onAppear() {
                    orderToCheck = Order(productID: product.id!, occurences: 1)
                }
                
                // product name and price (sale included)
                HStack(alignment: .bottom) {
                    Text(product.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    
                    if product.saleInPercents != nil {
                        VStack(alignment: .trailing) {
                            Text("₼ " + String(format: "%.2f", product.nonSalePrice!))
                                .font(.headline)
                                .bold()
                                .foregroundColor(.gray)
                                .strikethrough()
                            
                            Text("₼ " + String(format: "%.2f", product.price))
                                .font(.title3)
                                .bold()
                        }
                    } else {
                        Text("₼ " + String(format: "%.2f", product.price))
                            .font(.title3)
                            .bold()
                    }
                }
                .padding(.horizontal)
                
                // Color Selection Custom UI
                HStack {
                    Text("Color")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Color Picker Related UI
                Group {
                    ColorPickerView(product: product, colorSelected: $colorSelected, currentOrderToSet: $orderToCheck)
                    if showColorError {
                        Text("Please select a valid color")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
                
                // Size Selection Custom UI
                HStack {
                    Text("Size")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Size Picker Related UI
                Group {
                    SizePickerView(product: product, sizeSelected: $sizeSelected, currentOrderToSet: $orderToCheck)
                    
                    if sizeSelected?.rawValue == "Custom" {
                        HStack {
                            Text("Head size (sm)")
                            TextField("Enter", value: $headSizeInSm, formatter: NumberFormatter())
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            
                            Button(action: {
                                if headSizeInSm == 0 {
                                    showSizeError = true
                                } else {
                                    orderToCheck.sizeInSm = headSizeInSm
                                    showSizeError = false
                                }
                                
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
                        .padding()
                        .background(.ultraThickMaterial)
                        .cornerRadius(10)
                        .padding()
                    }
                    
                    if showSizeError {
                        Text("Please select a valid size")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
                
                if let description = product.description,
                    product.description != nil {
                    HStack {
                        Text(description)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                            .padding()
                        
                        Spacer()
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                // Buttons
                HStack {
                    // Add to basket button
                    Button(action: {
                        guard colorSelected != nil else {
                            showColorError = true
                            return
                        }
                        
                        showColorError = false

                        guard let sizeSelected = sizeSelected else {
                            showSizeError = true
                            return
                        }

                        if sizeSelected.rawValue == "Custom" && headSizeInSm == 0 {
                            showSizeError = true
                            return
                        }

                        showSizeError = false
                        
                        
                        for ord in baggies.load() {
                            if ord.productID == orderToCheck.productID
                                && ord.puffyColor == orderToCheck.puffyColor
                                && ord.size == orderToCheck.size
                                && ord.sizeInSm == orderToCheck.sizeInSm {
                                orderToCheck.occurences = ord.occurences
                            }
                        }
                        
                        print(orderToCheck)
                        
                        if baggies.contains(this: orderToCheck) {
                            baggies.removeCompletely(this: orderToCheck)
                        } else {
                            baggies.add(this: orderToCheck)
                        }
                  
                    }) {
                        HStack {
                            Image(systemName: baggies.contains(this: orderToCheck) ? "checkmark" : "plus")
                            Text(baggies.contains(this: orderToCheck) ? "Added to Bag": "Add to Bag")
                                .fontWeight(.semibold)
                            
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black)
                    .cornerRadius(24)

                    
                    // Favorites button
                    Image(systemName: "heart.fill")
                        .foregroundColor(favorites.contains(this: product) ? .red : .white)
                        .padding(17)
                        .background(.gray)
                        .clipShape(Circle())
                        .onTapGesture {
                            if favorites.contains(this: product) {
                                favorites.remove(this: product)
                            } else {
                                favorites.add(this: product)
                            }
                        }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
