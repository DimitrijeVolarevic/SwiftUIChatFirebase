//
//  ChatLogViewModel.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 4.5.23..
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    func handleSend() {
        print(chatText)
        
        guard let fromID = Auth.auth().currentUser?.uid else { return }
        
        guard let toID = chatUser?.uid else { return }
        
        let document = Firestore.firestore().collection("messages")
            .document(fromID)
            .collection(toID)
            .document()
        
        let messageData = ["fromId": fromID, "toId": toID, "text": self.chatText, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                print(error)
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            print("Successfully saved current user sending message")
            self.chatText = ""
        }
        
        let recipientMessageDocument = Firestore.firestore().collection("messages")
            .document(toID)
            .collection(fromID)
            .document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                print(error)
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            print("Recipient saved message as well")
        }
    }
}
