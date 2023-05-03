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
    
    @Published var isUserCurrentlyLoggedOut = false
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    
    init() {
        
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = Auth.auth().currentUser?.uid == nil
        }
        
        fetchCurrentUser()
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
            
            self.chatUser = .init(data: data)
            
        }
    }
    
    func signOut() {
        isUserCurrentlyLoggedOut.toggle()
        
        try? Auth.auth().signOut()
    }
}
