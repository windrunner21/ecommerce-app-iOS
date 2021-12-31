//
//  UserManager.swift
//  Meowclavas
//
//  Created by Imran on 31.12.21.
//

import Foundation
import Firebase

class UserManager: ObservableObject {
    // identifier
    let identifier = UUID()
        
    @Published var authState: Authorization
    @Published var authErrorMessage: String = String()
    @Published var resetErrorMessage: String = String()
    
    init() {
        if Auth.auth().currentUser != nil {
            authState = .loggedIn
        } else {
            authState = .loggedOut
        }
    }
    
    // signing user in
    func signInUser(_ email: String, and password: String) {
        self.authState = .unknown
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Some error occured.")
                self.authErrorMessage = error?.localizedDescription ?? "Error occured. Please try again."
                self.authState = .error
            } else {
                // set user name and email
                UserDefaults.standard.set(Auth.auth().currentUser?.displayName, forKey: "userFullName")
                
                print("Successfully logged in.")
                self.authState = .loggedIn
            }
        }
    }
    
    // resetting user password
    func resetPasswordUser(_ email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(error?.localizedDescription ?? "Sign in error occured.")
                self.resetErrorMessage = error?.localizedDescription ?? "Error occured. Please try again."
            } else {
                self.resetErrorMessage = "Success"
            }
        }
    }
    
    // signing user up
    func signUpUser(_ email: String, and password: String, for fullName: String) {
        self.authState = .unknown
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Sign up error occured.")
                self.authErrorMessage = error?.localizedDescription ?? "Error occured. Please try again."
                self.authState = .error
            } else {
                // set display name and email to user in firebase and user defaults
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = fullName
                
                UserDefaults.standard.set(fullName, forKey: "userFullName")
                
                // send email confirmation
                Auth.auth().currentUser?.sendEmailVerification { error in
                    if error != nil {
                        print(error?.localizedDescription ?? "Confirmation email error occured.")
                    }
                }
                
                print("Successfully created account.")
    
                self.authState = .loggedIn
            }
        }
    }
    
    // signing user out
    func signOutUser() {
        do {
            try Auth.auth().signOut()
            self.authState = .loggedOut
        } catch let signOutError as NSError {
            print("Error while signing out: \(signOutError)")
        }
    }
}
