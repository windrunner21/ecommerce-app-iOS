//
//  ProductDetailView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var baggies: Baggies
    @EnvironmentObject var favorites: Favorites
    @State private var headSizeInSm: Int = 0
    @FocusState private var isFocused: Bool
    var product: Product
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .topLeading) {
                    // product image ignoring safe area and clipped to fill
                    product.image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: UIScreen.main.bounds.size.width,
                            height: UIScreen.main.bounds.size.height / 2.5
                        )
                        .clipped()
                    
                    Button(){
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding([.leading, .top], 8)
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
                
                ColorPickerView(product: product)
                
                // Size Selection Custom UI
                HStack {
                    Text("Size")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                SizePickerView(product: product)
                
                if var currentOrder = modelData.orders.first(where: {$0.id == product.id!}) {
                    if currentOrder.size.rawValue == "Custom" {
                        HStack {
                            Text("Head size (sm)")
                            TextField("Enter", value: $headSizeInSm, formatter: NumberFormatter())
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                                .onAppear() {
                                    headSizeInSm = currentOrder.sizeInSm ?? headSizeInSm
                                }
                            
                            Button(action: {
                                guard let currentOrderIndex = modelData.orders.firstIndex(where: {$0.id == product.id!}) else {return}
                                currentOrder.sizeInSm = headSizeInSm
                                
                                modelData.orders[currentOrderIndex] = currentOrder
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
                        if baggies.contains(this: product) {
                            baggies.removeCompletely(this: product)
                        } else {
                            baggies.add(this: product)
                        }
                    }) {
                        HStack {
                            Image(systemName: baggies.contains(this: product) ? "checkmark" : "plus")
                            Text(baggies.contains(this: product) ? "Added to Bag": "Add to Bag")
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
        .onAppear() {
            let currentOrder = Order(product: product)
            
            // add order if it has not been already added
            if !modelData.orders.contains(where: {$0.id == product.id!}) {
                modelData.orders.append(currentOrder)
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: ModelData().products[0])
    }
}
