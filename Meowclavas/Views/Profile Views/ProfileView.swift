//
//  ProfileView.swift
//  Meowclavas
//
//  Created by Imran on 13.12.21.
//

import SwiftUI

// TODO: add user profile data structure

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ProfileHatView()
                ProfileOptionsView()
                    .offset(y: UIScreen.main.bounds.size.height / 5)
                    .accentColor(.black)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
