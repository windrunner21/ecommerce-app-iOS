//
//  AccountView.swift
//  Meowclavas
//
//  Created by Imran on 31.12.21.
//

import SwiftUI
import Firebase

struct AccountView: View {
    let fullName = UserDefaults.standard.string(forKey: "userFullName")
    let email: String = Auth.auth().currentUser?.email ?? "email not found"
    let isVerified: Bool = ((Auth.auth().currentUser?.isEmailVerified) != nil)
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Image(systemName: "envelope")
                Text(email)
                Spacer()
                if isVerified {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }

            }
            .padding()
            
            HStack {
                Spacer()
                Text(isVerified ? "account verified" : "account not verified")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .italic()
            }
            .padding(.horizontal)
            
            Divider()
            
            Spacer()
        }
        .navigationTitle(fullName ?? "Name not found")
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(UserManager())
    }
}
