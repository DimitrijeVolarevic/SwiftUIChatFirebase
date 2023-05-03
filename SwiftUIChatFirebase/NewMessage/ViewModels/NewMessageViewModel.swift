//
//  NewMessageViewModel.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 3.5.23..
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class NewMessageViewModel: ObservableObject {
    
    @Published var users: [ChatUser] = []
    
    func fetchAllUsers() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Failed to fetch users: ", error)
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({ (document) -> ChatUser? in
                let user = ChatUser(data: document.data())
                return user.uid == currentUserId ? nil : user
            })
        }
    }
    
}
