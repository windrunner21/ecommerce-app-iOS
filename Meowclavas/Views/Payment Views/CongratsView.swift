//
//  CongratsView.swift
//  Meowclavas
//
//  Created by Imran on 30.12.21.
//

import SwiftUI

struct CongratsView: View {
    @EnvironmentObject var baggies: Baggies
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20.0) {
            Spacer()
            
            LottieView(name: "success", loopMode: .playOnce)
                .frame(height: UIScreen.main.bounds.size.height / 6)
            
            Text("Congrats!")
                .font(.largeTitle)
                .bold()
            
            Text("Thank you for choosing us. Your order will be shipped in 1-2 working days.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 5)
            
            Spacer()
            
            // Continue button
            Button(action: {
                baggies.removeAll()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Continue Shopping")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(.primary)
            .cornerRadius(24)
            .padding([.vertical], 20)
        }
        .padding()
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView()
    }
}
