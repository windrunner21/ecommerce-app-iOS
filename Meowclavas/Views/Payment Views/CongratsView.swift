//
//  CongratsView.swift
//  Meowclavas
//
//  Created by Imran on 30.12.21.
//

import SwiftUI

struct CongratsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20.0) {
            Spacer()
            
            Image(systemName: "checkmark")
                .font(.system(size: 80))
                .padding(40)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            
            Text("Congrats!")
                .font(.largeTitle)
                .bold()
            
            Text("Thank you for choosing us. Your order will be shipped in 2-4 working days")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Continue button
            Button(action: {
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
