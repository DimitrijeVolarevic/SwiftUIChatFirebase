//
//  MainMessagesViewModel.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 2.5.23..
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MainMessagesViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    struct ChatUser {
        let uid, email, profileImageURL: String
    }
    
    func fetchCurrentUser() {
        
        
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }

        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }

            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageURL = data["profileImageURL"] as? String ?? ""
            self.chatUser = ChatUser(uid: uid, email: email.replacingOccurrences(of: "@gmail.com", with: ""), profileImageURL: profileImageURL)
            
            print("Fetched user data successfully: \(email), \(uid), \(profileImageURL)")
            
        }
    }
    

}
