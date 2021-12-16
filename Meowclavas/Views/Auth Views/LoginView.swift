//
//  LoginView.swift
//  Meowclavas
//
//  Created by Imran on 11.12.21.
//

import SwiftUI
import AuthenticationServices

// TODO: create check for errors and add log in functionality

/// Authentication View that allows User to sign in via email/password method as well as  Sign In with Apple and Google Sign in.
struct LoginView: View {
    // authorization enum
    @Binding var authState: Authorization
    
    // email related variables
    @State private var email: String = String()
    @State private var showEmailError: Bool = false
    
    // password related variables
    @State private var password: String = String()
    @State private var showPasswordError: Bool = false
    @FocusState private var passwordIsFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // title
                HStack {
                    Text("Log into")
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
                        .keyboardType(.emailAddress)
                    
                    if showEmailError {
                        Text("Email cannot be empty.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    
                    Divider()
                    
                    // Password Text field and Error
                    HStack {
                        SecureField(
                            "Password",
                            text: $password
                        ) {
                            handleLogin(email: email, password: password)
                        }
                        .focused($passwordIsFocused)
                        
                        
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot?")
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                                .font(.callout)
                        }
                    }
                    
                    if showPasswordError {
                        Text("Password cannot be empty.")
                            .font(.footnote)
                        .foregroundColor(.red)
                    }
            
                }
                .padding()
                .background(Color("PaperColor"))
                .cornerRadius(10)
                
                // Log in button
                Button(action: {
                    authState = .loggedIn
                }) {
                    Text("Log In")
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
                    Button(action: {
                        authState = .loggedIn
                    }) {
                        Image("SignInWithAppleLogo-OnlyWhite")
                    }
                    .background(.black)
                    .cornerRadius(10)
                    
                    Text("or")
                    
                    Button(action: {
                        print("google log in clicked")
                        authState = .loggedIn
                    }) {
                        Image("GoogleSignIn")
                    }
                    .padding(13.5)
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding([.vertical])

                // Expand Space
                Spacer()
                
                // Go to Sign Up Page
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView(authState: $authState)) {
                        Text("Sign Up")
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
        .accentColor(Color.primary)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authState: .constant(.loggedOut))
    }
}

func handleLogin(email: String, password: String) {
    print("handle login executing")
}
