//
//  RecentMessage.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 7.5.23..
//

import Foundation
import Firebase

struct RecentMessage: Identifiable {
    
    var id: String { documentID }
    
    let documentID: String
    let text: String
    let fromId, toId: String
    let profileImageURL: String
    let email: String
    let timestamp: Firebase.Timestamp
    
    init(documentID: String, data: [String: Any]) {
        self.documentID = documentID
        self.text = data["text"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
    }
}
