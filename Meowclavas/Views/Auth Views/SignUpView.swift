//
//  SignUpView.swift
//  Meowclavas
//
//  Created by Imran on 11.12.21.
//

import SwiftUI
import Firebase

// TODO: add sign up apple and google

/// Authentication View that allows User to sign up via email/password method
struct SignUpView: View {
    // user manager environment object
    @EnvironmentObject var userManager: UserManager
        
    // full name related variables
    @State private var fullName: String = String()
    @State private var showFullNameError: Bool = false
    
    // email related variables
    @State private var email: String = String()
    @State private var showEmailError: Bool = false
    @FocusState private var emailIsFocused: Bool
    
    // password related variables
    @State private var password: String = String()
    @State private var showPasswordError: Bool = false
    @FocusState private var passwordIsFocused: Bool
    
    // dismiss page on custom back to log in clicked
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // title
                HStack {
                    Text("Create")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack {
                    Text("your account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                // registration form
                VStack(alignment: .leading) {
                    // Full Name Text Field and Error
                    TextField(
                        "Your Name",
                        text: $fullName,
                        onCommit: {
                            if !fullName.isEmpty {
                                emailIsFocused = true
                            }
                        }
                    )
                        .autocapitalization(.words)

                    if showFullNameError {
                        Text("Your name cannot be empty.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    
                    Divider()
                    
                    // Email Text Field and Error
                    TextField(
                        "Email",
                        text: $email,
                        onCommit: {
                            if !email.isEmpty {
                                passwordIsFocused = true
                            }
                        }
                    )
                        .focused($emailIsFocused)
                        .keyboardType(.emailAddress)
                    
                    if showEmailError {
                        Text("Email cannot be empty.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    
                    Divider()
                    
                    // Password Text field and Error
                    SecureField(
                        "Password",
                        text: $password
                    ) {
                        handleSignUp()
                    }
                        .focused($passwordIsFocused)
                    
                    if showPasswordError {
                        Text("Password cannot be empty.")
                            .font(.footnote)
                        .foregroundColor(.red)
                    }
                    
                }
                .padding()
                .background(Color("PaperColor"))
                .cornerRadius(10)
                
                // error or progress indicator
                Group {
                    if !userManager.authErrorMessage.isEmpty {
                        Text(userManager.authErrorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                
                    if userManager.authState == .unknown {
                        ProgressView()
                    }
                
                    // Terms of Service Agreement accepted by default
                    HStack(alignment: .top) {
                        Image(systemName: "checkmark.square.fill")
                            .font(.system(size: 19))
                        Text("by signing up you agree to terms of service and privacy policy")
                            .font(.caption)
                        Spacer()
                    }
                    .padding([.top])
                }
                
                // Sign up button
                Button(action: {
                    passwordIsFocused = false
                    handleSignUp()
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(.black)
                .cornerRadius(24)
                .padding([.vertical], 20)
                
                // Alternative sign in prompt
                Text("Or sign up with social account")
                    .fontWeight(.medium)
                
                // Sign in via Apple and Google buttons
                HStack(spacing: 20.0) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image("SignInWithAppleLogo-OnlyWhite")
                    }
                    .background(.black)
                    .cornerRadius(10)
                    
                    Text("or")
                    
                    Button(action: {
                        print("log in clicked")
                    }) {
                        Image("GoogleSignIn")
                    }
                    .padding(13.5)
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding([.vertical])
                
                Spacer()
                
                // Go to Log In Screen
                HStack {
                    Text("Already have account?")
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Log In")
                            .underline()
                            .accentColor(.blue)
                    }
                    Spacer()
                }
                .font(.callout)
            }
            .padding(30)
            .background(Color("MainColor"))
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    // sign up via email and password
    func handleSignUp() {
        if email.isEmpty {
            showEmailError = true
        } else {
            showEmailError = false
        }
        
        if password.isEmpty {
            showPasswordError = true
        } else {
            showPasswordError = false
        }
        
        if fullName.isEmpty {
            showFullNameError = true
        } else {
            showFullNameError = false
        }
        
        if !email.isEmpty && !password.isEmpty && !fullName.isEmpty {
            userManager.signUpUser(email, and: password, for: fullName)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
