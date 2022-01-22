//
//  BasketView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

struct BasketView: View {
    @State private var promoCode: String = String()
    @State private var tempCount: Int = 1
    @EnvironmentObject var baggies: Baggies
    @State var bagProducts: [Product]
    var totalPrice: Double {
        var tempPrice = 0.0
        
        for product in bagProducts {
            tempPrice += product.price
        }
        
        return tempPrice
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
                                
                                Text(String(tempCount))
                                    .onTapGesture(count: 2) {
                                        tempCount += 1
                                    }
                                    .onLongPressGesture {
                                        tempCount -= 1
                                    }
                                .padding()
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(24)
                            }
                        }
                        .onDelete(perform: delete)
                        .padding(.vertical)
                    }
                    .listStyle(.inset)
                    
                    HStack {
                        Text("Promo code")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("enter code", text: $promoCode)
                            .font(.system(size: 19, weight: .bold))
                            .multilineTextAlignment(.trailing)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                promoCode = String()
                            }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Total amount")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("₼ " + String(format: "%.2f", totalPrice))
                            .font(.title3)
                            .bold()
                            .foregroundColor(.gray)
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
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .accentColor(.primary)
    }
    
    // delete from basket
    func delete(at offsets: IndexSet) {
        if baggies.load().count == 1 {
            withAnimation(.easeInOut) {
                baggies.remove(this: bagProducts[offsets.first!])
                bagProducts.remove(atOffsets: offsets)
            }
        } else {
            baggies.remove(this: bagProducts[offsets.first!])
            bagProducts.remove(atOffsets: offsets)
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
