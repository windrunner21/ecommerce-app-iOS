//
//  DotSpacerView.swift
//  Meowclavas
//
//  Created by Imran on 26.12.21.
//

import SwiftUI

struct DotSpacerView: View {
    var body: some View {
        ForEach(1...4, id: \.self) { _ in
            Circle()
                .frame(width: 5, height: 5)
                .frame(maxWidth: .infinity)

        }
    }
}

struct DotSpacerView_Previews: PreviewProvider {
    static var previews: some View {
        DotSpacerView()
    }
}
