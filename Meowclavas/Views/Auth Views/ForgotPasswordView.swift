//
//  ForgotPasswordView.swift
//  Meowclavas
//
//  Created by Imran on 12.12.21.
//

import SwiftUI

/// View that allows User to change password via email link, in case the password is forgotten.
struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager
    @State private var resetEmail: String = String()
    
    var body: some View {
        VStack(spacing: 10.0) {
            // title
            HStack {
                Text("Forgot Password?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            // subtitle
            HStack {
                Text("If you need help resetting your password, we can help by sending you a link to reset it.")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Spacer()
            }
            
            // Reset email Text Field
            HStack {
                Image(systemName: "envelope.fill")
                TextField("Email", text: $resetEmail)
                    .keyboardType(.emailAddress)
            }
            .padding([.top], 30)
            
            Divider()
            
            if userManager.resetErrorMessage == "Success" {
                // Send reset password email button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Success! Go Back")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(.green)
                .cornerRadius(24)
                .padding([.vertical], 20)
            } else {
                // Send reset password email button
                Button(action: {
                    userManager.resetPasswordUser(resetEmail)
                }) {
                    Text("Send")
                        .foregroundColor(Color(UIColor.systemBackground))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(.primary)
                .cornerRadius(24)
                .padding([.vertical], 20)
            }
            
            if !userManager.resetErrorMessage.isEmpty || userManager.resetErrorMessage != "Success" {
                Text(userManager.resetErrorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding([.horizontal],30)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(UserManager())
    }
}
