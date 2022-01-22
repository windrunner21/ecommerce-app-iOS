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
    @State var bagProducts: [Product]
    @State private var promoCode: String = String()
    @State private var showingHelp: Bool = false
    @State private var codePriceOff: Int = 0
    var totalPrice: Double {
        var tempPrice = 0.0
        
        for product in bagProducts {
            tempPrice += (product.price * Double(baggies.load()[product.id!]!))
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
                    Spacer()
                }
                .navigationTitle("My Bag")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                VStack {
                    List {
                        ForEach(bagProducts, id: \.self) { product in
                            HStack {
                                product.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.title3)
                                        .bold()
                                    
                                    Text("₼ " + String(format: "%.2f", product.price))
                                        
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Size: M")
                                        Divider()
                                        Text("Color: gray")
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(height: 25)
                                }
                                
                                Spacer()
                                
                                Text(String(baggies.load()[product.id!]!))
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
                                    
                                    // remove only if dictionary is completely empty
                                    if !baggies.load().keys.contains(product.id!) {
                                        if let index = bagProducts.firstIndex(of: product) {
                                            bagProducts.remove(at: index)
                                        }
                                    }
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

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(
            bagProducts: ModelData().products
        )
            .environmentObject(UserManager())
    }
}
