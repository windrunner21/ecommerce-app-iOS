//
//  BasketView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct BasketView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var baggies: Baggies
    
    @State private var promoCode: String = String()
    @State private var showingHelp: Bool = false
    @State private var codePriceOff: Int = 0
    var totalPrice: Double {
        var tempPrice = 0.0
        
        for product in baggies.load() {
            tempPrice += (modelData.products.first(where: {$0.id! == product.productID})!.price * Double(product.occurences!))
        }
        
        return tempPrice
    }
    var totalPriceWithSale: Double {
        return totalPrice * Double(100 - codePriceOff) / 100
    }
    
    var body: some View {
        NavigationView {
            if baggies.load().isEmpty {
                VStack {
                    Spacer()
                    LottieView(name: "shopping-bag-empty", loopMode: .loop)
                        .frame(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.height / 4)
                    Text("Oh no! Looks like your bag is empty.")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .navigationTitle("My Bag")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                VStack {
                    List {
                        ForEach(baggies.load(), id: \.self) { product in
                            HStack {
                                modelData.products.first(where: {$0.id! == product.productID})!.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipped()
                                    .cornerRadius(10)

                                VStack(alignment: .leading) {
                                    Text(modelData.products.first(where: {$0.id! == product.productID})!.name)
                                        .font(.title3)
                                        .bold()

                                    Text("₼ " + String(format: "%.2f", modelData.products.first(where: {$0.id! == product.productID})!.price))
                                        
                                    
                                    Spacer()
                                    
                                    HStack(alignment: .center) {
                                        Text("Size: \(NSLocalizedString(product.size!.rawValue, comment: ""))")
                                        Divider()
                                        HStack {
                                            Text("Color:")
                                            Image(product.puffyColor!.rawValue)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 15, height: 15)
                                            .clipShape(Circle())
                                        }
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(height: 25)
                                }
                                
                                Spacer()
                                
                                Text(String(product.occurences!))
                                .padding()
                                .background(Color(UIColor.systemGray4))
                                .cornerRadius(24)
                            }
                            .swipeActions(edge: .leading) {
                                Button("Add") {
                                    baggies.add(this: product)
                                }
                                .tint(.indigo)
                            }
                            .swipeActions(edge: .trailing) {
                                Button("Delete") {
                                    baggies.remove(this: product)
                                }
                                .tint(.red)
                            }
                        }
                        .padding(.vertical)
                    }
                    
                    HStack {
                        Text("Promo code")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        // if code applied show code and check else can write new code
                        if codePriceOff != 0 {
                            Text(promoCode)
                                .font(.system(size: 19, weight: .bold))
                                .multilineTextAlignment(.trailing)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            TextField(
                                "enter code",
                                text: Binding(
                                    get: { self.promoCode },
                                    set: {
                                        self.promoCode = $0.uppercased().filter {!$0.isWhitespace}
                                    }),
                                onCommit: {
                                    checkAndApplyPromoCode(promoCode)
                                }
                                )
                                .font(.system(size: 19, weight: .bold))
                                .multilineTextAlignment(.trailing)
                            
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    promoCode = String()
                                }
                        }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    HStack(alignment: .bottom) {
                        Text("Total amount")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        if codePriceOff != 0 {
                            VStack(alignment: .trailing) {
                                Text("₼ " + String(format: "%.2f", totalPrice))
                                    .font(.headline)
                                    .strikethrough()
                                    .bold()
                                    .foregroundColor(.gray)

                                
                                Text("₼ " + String(format: "%.2f", totalPriceWithSale))
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.gray)
                            }
                        } else {
                            Text("₼ " + String(format: "%.2f", totalPrice))
                                .font(.title3)
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    
                    
                    NavigationLink(destination: PaymentView()) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.black)
                            .cornerRadius(24)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        modelData.userOrder.orderedItems = baggies.load()
                        if codePriceOff != 0 {
                            modelData.userOrder.promoCode = promoCode
                            modelData.userOrder.finalPrice = totalPriceWithSale
                        } else {
                            modelData.userOrder.finalPrice = totalPrice
                        }
                    })
                    .padding()
                    
                }
                .navigationTitle("My Bag")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            if showingHelp {
                                Text("Bag items are swipeable. Left to delete. Right to add.")
                                    .font(.caption)
                                    .fontWeight(.light)
                            }
                            
                            Button() {
                                showingHelp.toggle()
                            } label: {
                                Image(systemName: showingHelp ? "checkmark.bubble" : "exclamationmark.bubble")
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onAppear() {
            modelData.fetchPromoCodes()
        }
        .accentColor(.primary)
    }
    
    
    // check promo code, if valid apply discount
    func checkAndApplyPromoCode(_ code: String) {
        for promocode in modelData.promoCodes {
            if promocode.code == code {
                codePriceOff = promocode.off
            }
        }
    }
}
