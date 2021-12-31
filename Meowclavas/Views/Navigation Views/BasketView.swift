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
    @State var bagProducts: [Product]

    var body: some View {
        NavigationView {
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
                    .onDelete { bagProducts.remove(atOffsets: $0) }
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
                    
                    Text("₼ " + String(format: "%.2f", 20))
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
        .accentColor(.primary)
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
