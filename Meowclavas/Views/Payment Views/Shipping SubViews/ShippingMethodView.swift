//
//  ShippingMethodView.swift
//  Meowclavas
//
//  Created by Imran on 27.12.21.
//

import SwiftUI

struct ShippingMethodView: View {
    var free: Bool
    var option: String
    @Binding var checked: Bool
    @Binding var alternativeChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: checked ?
                  "checkmark.square.fill" : "checkmark.square")
                .font(.system(size: 24))
                .foregroundColor(checked ?
                                    .green : .primary)
            Text(NSLocalizedString(option, comment: ""))
                .foregroundColor(checked ?
                                    .primary : Color(UIColor.systemGray2))
                .font(.system(size: 19, weight: .semibold))
            Spacer()
            Text(free ? "( \(NSLocalizedString("Free", comment: "")) )" : "( + ₼ 10.00 )")
                .foregroundColor(checked ?
                                    .primary : Color(UIColor.systemGray2))
        }
        .padding()
        .onTapGesture {
            checked.toggle()
            alternativeChecked.toggle()
        }
        .background(.ultraThickMaterial)
        .cornerRadius(10)
    }
}

struct ShippingMethodView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingMethodView(
            free: false,
            option: "Nearest Subway Station",
            checked: .constant(false),
            alternativeChecked: .constant(true)
        )
    }
}
