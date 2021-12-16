//
//  OptionRowView.swift
//  Meowclavas
//
//  Created by Imran on 15.12.21.
//

import SwiftUI

struct OptionRowView: View {
    var iconSystemName: String
    var optionName: String
    var navigationLink: Bool
    
    var body: some View {
        HStack {
            Image(systemName: iconSystemName)
                .font(.system(size: 25))
            Text(optionName)
                .fontWeight(.semibold)

            Spacer()
            
            if navigationLink {
                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .medium))
            }
        }
        .background(Color(UIColor.systemBackground))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct OptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        OptionRowView(
            iconSystemName: "mappin",
            optionName: "My Address",
            navigationLink: true
        )
    }
    
}
