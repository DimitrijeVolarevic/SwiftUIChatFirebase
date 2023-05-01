//
//  AuthViewModel.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 1.5.23..
//

import Foundation
import Firebase
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var loginStatusMessage = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("User session is \(self.userSession)")
    }
    
    func logIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login with error: ", error)
                self.loginStatusMessage = "Failed to login with error: \(error)"
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    func register(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to register with error: ", error)
                self.loginStatusMessage = "Failed to register with error: \(error)"
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("Registered user successfully: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Registered user successfully: \(result?.user.uid ?? "")"
        }
    }
}
