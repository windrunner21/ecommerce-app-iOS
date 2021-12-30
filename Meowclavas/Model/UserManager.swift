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
    
    init() {
        if Auth.auth().currentUser != nil {
            authState = .loggedIn
        } else {
            authState = .loggedOut
        }
    }
    
    func signOutUser() {
        authState = .loggedOut
    }
}
