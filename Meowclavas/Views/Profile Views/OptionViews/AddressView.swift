//
//  AddressView.swift
//  Meowclavas
//
//  Created by Imran on 15.12.21.
//

import SwiftUI

struct AddressView: View {
    @EnvironmentObject var shipment: Shipping
    
    var body: some View {
        Text(shipment.load().fullName)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
            .environmentObject(Shipping())
    }
}
