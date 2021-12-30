//
//  StepIndicatorView.swift
//  Meowclavas
//
//  Created by Imran on 26.12.21.
//

import SwiftUI

struct StepIndicatorView: View {
    @Binding var step2Active: Bool
    @Binding var step3Active: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
                .font(.system(size: 24))
                .padding(.trailing)
            
            DotSpacerView()
                .foregroundColor(step2Active ? .primary : .gray)
            
            Image(systemName: "creditcard.fill")
                .font(.system(size: 24))
                .padding(.horizontal)
                .foregroundColor(step2Active ? .primary : .gray)
            
            DotSpacerView()
                .foregroundColor(step3Active ? .primary : .gray)
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 24))
                .padding(.leading)
                .foregroundColor(step3Active ? .primary : .gray)
        }
        .padding()
    }
}

struct StepIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        StepIndicatorView(
            step2Active: .constant(false),
            step3Active: .constant(false)
        )
    }
}
