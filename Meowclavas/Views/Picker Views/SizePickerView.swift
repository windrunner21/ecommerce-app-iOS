//
//  SizePickerView.swift
//  Meowclavas
//
//  Created by Imran on 17.12.21.
//

import SwiftUI

struct SizePickerView: View {
    @State private var sizeSelected: Size = .small
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(Size.allCases, id: \.self) { size in
                    if size == sizeSelected {
                        Text(size.rawValue)
                            .bold()
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                        
                            .frame(width: 50, height: 50)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.white, lineWidth: 4)
                            }
                            .shadow(radius: 3)
                            .onTapGesture {
                                sizeSelected = size
                            }
                    } else {
                        Text(size.rawValue)
                            .bold()
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                        
                            .frame(width: 50, height: 50)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                            .onTapGesture {
                                sizeSelected = size
                            }
                    }
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal)
        }
    }
}

struct SizePickerView_Previews: PreviewProvider {
    static var previews: some View {
        SizePickerView()
    }
}
