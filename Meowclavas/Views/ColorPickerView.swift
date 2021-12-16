//
//  ColorPickerView.swift
//  Meowclavas
//
//  Created by Imran on 17.12.21.
//

import SwiftUI

struct ColorPickerView: View {
    @State private var colorSelected: Colors = .white
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(Colors.allCases, id: \.self) { color in
                    if color == colorSelected {
                        Text(String())
                            .bold()
                            .textCase(.uppercase)
                            .frame(width: 50, height: 50)
                            .background(Color(color.rawValue).opacity(0.8))
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.white, lineWidth: 4)
                            }
                            .shadow(radius: 3)
                            .onTapGesture {
                                colorSelected = color
                            }
                    } else {
                        Text(String())
                            .bold()
                            .textCase(.uppercase)
                            .frame(width: 50, height: 50)
                            .background(Color(color.rawValue).opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: color.rawValue == "BalaclavaWhite" ? 1 : 0)
                            .onTapGesture {
                                colorSelected = color
                            }
                    }
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal)
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
